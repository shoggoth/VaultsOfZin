class_name Spawner extends Marker2D

signal spawned(mob: Mob)
signal destroyed(mob: Mob)

const TYPE_COUNT = 3

@export var mob_scene: PackedScene
@export var initial_pool_size = 0

var _pool = []

func _ready():
	for _i in initial_pool_size: _pool.append(mob_scene.instantiate())

func clear():
	for i in get_children(): i.queue_free()

func spawn():
	if _pool.is_empty(): _pool.append(mob_scene.instantiate())
