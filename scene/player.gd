class_name Player extends CharacterBody2D

func _input(event: InputEvent) -> void:
	print(event)

func _physics_process(delta: float) -> void:
	velocity += delta * Global.gravity
	velocity.x = 10
	move_and_slide()
