extends Node

@export var pool_group := "return_to_pool"				## Nodes in this group will be returned to the pool during the next sweep
@export var pool_fill_count: int = 1
@export_range(-1, 0) var child_index: int = -1

@onready var pool: Node = %Pool
@onready var live: Node = %Live

func _ready() -> void:
	if !pool: push_error("No pool and/or live node set")

func _physics_process(_delta: float) -> void:
	for o in live.get_children():
		if o.is_in_group(pool_group):
			o.remove_from_group(pool_group)
			o.reparent(pool)

func spawn(create: Callable, setup: Callable) -> void:
	if !pool.get_child_count():
		for i in pool_fill_count:
			pool.add_child(create.call(i))
	var spawned = pool.get_child(child_index)
	setup.call(spawned).reparent(live)

func spawn_scene(scene: PackedScene, setup: Callable) -> void:
	spawn(func(_i): return scene.instantiate(), setup)

func _messing():
	var _l := func(o: Object, s: Callable):
		if "name" in o: print(o.name)
		if o != pool && "hide" in o: o.hide()
		s.call(o)
		return true
	var setup = func(o: Node):
		print("Setting up ", o)

	get_children().all((func(o: Object, s: Callable):
		if "setup" in o: s.call(o)
		return true
		).bind(setup))
