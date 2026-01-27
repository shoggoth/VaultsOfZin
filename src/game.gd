class_name Game extends Node

var _main_menu: MainMenu

func new_game() -> void:
	print("Start New Game")
	_main_menu.queue_free()

func _shortcut_input(event: InputEvent) -> void:
	# Check for the main menu input event and toggle if need to.
	if event.is_action("main_menu") && event.is_pressed() && !event.is_echo():
		if !_main_menu:
			_main_menu = $MainMenu.create_instance()
		else:
			_main_menu.free()
