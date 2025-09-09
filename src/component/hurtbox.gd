class_name HurtBox extends Area2D

@export var health_component: HealthComponent
@export var free_hit_boxen: bool = false

func _ready():
	if !area_entered.is_connected(_on_area_entered):
		area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D):
	if health_component && area is HitBox:
		health_component.damage(area.damage_dealt)
		if free_hit_boxen: area.queue_free()
