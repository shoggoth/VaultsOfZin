class_name HurtBox extends Area2D

@export var health_component: Health
@export var free_hit_boxen := false

func _on_area_entered(area: Area2D):
	if area is HitBox:
		area.hit(self)
		if health_component: health_component.damage(area.damage_dealt)
		if free_hit_boxen: area.queue_free()

func _on_body_entered(_body: Node2D) -> void:
	print("TODO: decide what to do with body collisions")
