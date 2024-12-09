extends Button

@onready var game_manager: Node = %game_manager

func _on_pressed() -> void:
	pass # Replace with function body.
	game_manager.go_to_main_menu()
