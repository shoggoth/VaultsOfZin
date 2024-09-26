extends Node


var _world
var _world_count: int


func _ready():
	Global.global_test()
	_new_world()


func _new_world():
	if _world: _world.queue_free()
	_world = $World.create_instance()
	_world.name = "World" + str(_world_count)
	_world_count += 1
