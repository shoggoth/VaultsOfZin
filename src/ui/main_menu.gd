class_name MainMenu extends CanvasLayer

@export var game: Game

func _on_new_game_pressed() -> void:
	game.new_game()
