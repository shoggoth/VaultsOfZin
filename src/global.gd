extends Node

@export var test_string: String

var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity")

func global_test():
	print("Global Test ", test_string, " ", gravity)
