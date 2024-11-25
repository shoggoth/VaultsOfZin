class_name Spawner extends Marker2D

signal spawned(enemy: Enemy)
signal destroyed(enemy: Enemy)
signal snapshot_changed(snapshot: Spawner.Snapshot)

const TYPE_COUNT = 3

@export var enemy_scene: PackedScene
@export var grid_size = Vector2(7, 6)

var snapshot := Snapshot.new()

func _ready():
	print("Spawner : ", self.global_position, " ", self.name)

func clear_current_level():
	snapshot = Snapshot.new()
	for i in get_children(): i.queue_free()

func spawn_level(_level_number = 1):
	for x in grid_size.x - 1: spawn(Vector2(x + 0.5, 0))
	for y in grid_size.y - 1: spawn(Vector2(0, y + 0.5))
	for y in grid_size.y - 1: spawn(Vector2(grid_size.x, y + 0.5))

	snapshot.active_count = get_child_count()
	snapshot_changed.emit(snapshot)

func spawn(pos: Vector2, type: int = 0) -> Enemy:
	var e: Enemy = enemy_scene.instantiate()
	e.position = pos
	e.spawn_pos = pos
	e.respawn = respawn
	e.destroyed = func(_name): respawn(e)
	e.type = type
	add_child(e)
	spawned.emit(e)
	return e

func respawn(e: Enemy):
	destroyed.emit(e)
	if e.type < TYPE_COUNT:
		spawn(e.spawn_pos, e.type + 1)
		snapshot.mutation_count += 1
	else:
		snapshot.active_count -= 1
	snapshot.destroyed_count += 1
	snapshot_changed.emit(snapshot)

class Snapshot:
	var active_count: int
	var destroyed_count: int
	var mutation_count: int
