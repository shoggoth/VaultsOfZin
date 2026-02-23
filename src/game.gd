class_name Game extends Node

var _main_menu: MainMenu

func new_game() -> void:
	print("Start New Game")

func _unhandled_input(event: InputEvent) -> void:
	# Check for the main menu input event and toggle if need to.
	if event.is_action("main_menu"):
		get_viewport().set_input_as_handled()
		if !_main_menu && event.is_pressed() && !event.is_echo(): _main_menu = $MainMenu.create_instance()
