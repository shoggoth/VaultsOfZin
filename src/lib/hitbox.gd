class_name HitBox extends Area2D

signal hit_hurt_box(HurtBox)

@export var damage_dealt := 1.0

func hit(hurt_box: HurtBox):
	hit_hurt_box.emit(hurt_box)
