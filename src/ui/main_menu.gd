class_name MainMenu extends CanvasLayer

signal menu_option_chosen(String)

@onready var animation_player := $AnimationPlayer

func close() -> void:
	animation_player.play("close")

func _on_new_game_pressed() -> void:
	menu_option_chosen.emit("Temp")
	close()
