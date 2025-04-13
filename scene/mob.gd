@tool class_name Mob extends Node2D

@export var base_frame: int = 1

var recycle: Callable
var destroyed: Callable

func _ready() -> void:
	if Engine.is_editor_hint():
		print("In editor")
	$Sprite2D.frame = base_frame
