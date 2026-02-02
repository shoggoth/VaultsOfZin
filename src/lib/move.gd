class_name PlatformMovement extends Node

@export var body: CharacterBody2D
@export_group("Running")
@export var max_speed := 90.0
@export var acceleration := 900.0
@export var air_multiplier := 0.7
@export_group("Jumping")
@export var max_jumps := 1
@export var jump_velocity := -300.0
@export var jump_x_boost := 0.0
@export var jump_gravity := 1.0
@export var jump_buffer_time := 0.0
@export_range(0.0, 1.0) var jump_height_multiplier = 1.0
@export_group("Falling")
@export var terminal_velocity := 180.0
@export var fall_gravity := 0.4
@export var coyote_time := 0.0

var direction := 0.0
var jump_button_pressed = false
var jump_button_held = false
var jump_count := 0
var sm = FSMNode.FSM.new([
FSMNode.FSM.State.new("Idle",
	Util.nc,
	func(delta: float):
		move(delta, false)
		if body.is_on_floor():
			if jump_button_pressed: sm.enter_state("Jump")
			elif direction: sm.enter_state("Run")
		else:
			sm.enter_state("Fall")
		),
FSMNode.FSM.State.new("Run",
	Util.nc,
	func(delta: float):
		move(delta, false)
		if !body.is_on_floor():
			sm.enter_state("Fall")
		elif jump_button_pressed:
			sm.enter_state("Jump")
		elif !direction:
			sm.enter_state("Idle")
		),
FSMNode.FSM.State.new("Jump",
	func(_s: FSMNode.FSM.State):
		jump(direction),
	func(delta: float):
		move(delta, true, true)
		if body.velocity.y >= 0: sm.enter_state("Fall")
		elif jump_button_pressed:
			jump(direction)
		elif !jump_button_held:
			body.velocity.y *= jump_height_multiplier
		),
FSMNode.FSM.State.new("Fall",
	Util.nc,
	func(delta: float):
		move(delta, true)
		if body.is_on_floor():
			jump_count = 0
			sm.enter_state("Run" if direction else "Idle")
		)
])

#region Movement
func move(delta: float, apply_g: bool, jumping: bool = false) -> void:
		_accelerate(delta)
		if apply_g: _apply_gravity(delta, jumping)
		body.move_and_slide()

func jump(x_boost := 0.0):
	jump_count += 1
	if jump_count > max_jumps: return
	body.velocity.y = jump_velocity
	body.velocity.x += x_boost * max_speed * jump_x_boost

func _accelerate(delta: float):
	var m = air_multiplier if !body.is_on_floor() else 1.0
	body.velocity.x = move_toward(body.velocity.x, max_speed * direction, m * acceleration * delta)
	#if direction: body.sprite.flip_h = (direction < 0)

func _apply_gravity(delta: float, jumping: bool) -> void:
	var g = (jump_gravity if jumping else fall_gravity) * body.get_gravity().y
	body.velocity.y = move_toward(body.velocity.y, terminal_velocity, g * delta)
#endregion

func _ready() -> void:
	sm.enter_state("Idle")

func _physics_process(delta: float) -> void:
	sm.update(delta)
