extends Button

@onready var game_manager: Node = %game_manager

func _on_pressed() -> void:
	game_manager.switch_to_level_0()
