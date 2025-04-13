class_name Spawner extends Marker2D

signal spawned(node: Node)
signal destroyed(node: Node)

const TYPE_COUNT = 3

@export var scene: PackedScene
@export var initial_pool_size = 0

var _pool = []

func _ready():
	for _i in initial_pool_size: _pool.append(scene.instantiate())

func clear():
	for i in get_children(): i.queue_free()

func spawn():
	if _pool.is_empty(): _pool.append(scene.instantiate())
	var spawned = _pool.pop_front()
