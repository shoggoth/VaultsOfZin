class_name PlatformController extends Node

@export var movement: PlatformMovement
@export var jump_buffer_time := 0.0									# Buffer time for variable jump height (s)

var jump_button_pressed := false:
	get: return _jbp || _jbt < jump_buffer_time
var fire_button_held := false:
	get: return Input.is_action_pressed("fire")

var _jbp := false
var _jbt := 0.0

func _physics_process(delta: float) -> void:
	movement.direction = Input.get_axis("left", "right")
	_jbp = Input.is_action_just_pressed("jump")
	_jbt = 0.0 if _jbp else _jbt + delta
	movement.jump_button_held = Input.is_action_pressed("jump")
	movement.jump_button_pressed = jump_button_pressed
