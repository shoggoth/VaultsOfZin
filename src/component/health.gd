class_name HealthComponent extends Node


signal health_changed(health: float)
signal invincibility_changed(state: bool)

@export_group("Health")
@export var max_health: float = 1.0
@export var health: float = 1.0
@export var damage_factor: float = 1.0
@export_group("Invincibility")
@export var invincibility_time: float = -1

var invincible := false: set = _set_invincible
var _invincibility_timer := Timer.new()


func _ready():
	_invincibility_timer.one_shot = true
	_invincibility_timer.name = "Invincibility Timer"
	_invincibility_timer.timeout.connect(func(): invincible = false)
	add_child(_invincibility_timer)


func damage(dmg: float) -> float:
	if !invincible:
		dmg *= damage_factor
		health -= dmg
		if health > 0: invincible = invincibility_time > 0
		health_changed.emit(health)
	return health


func heal(amount: float) -> float:
	health = clamp(health + amount, health, max_health)
	health_changed.emit(health)
	return health


func _set_invincible(value: bool):
	if value == invincible: return
	invincible = value
	invincibility_changed.emit(invincible)
	_invincibility_timer.start(invincibility_time) if value else _invincibility_timer.stop()
