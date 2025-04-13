extends Node

@export var gravity_scale: float = 1.0

var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_scale

func global_test():
	print("Global Test ", gravity_scale, " ", gravity)
