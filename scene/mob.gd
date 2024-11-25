class_name Mob extends Node2D

@export var base_frame: int = 1

var recycle: Callable
var destroyed: Callable

func _ready() -> void:
	$Sprite2D.frame = base_frame
