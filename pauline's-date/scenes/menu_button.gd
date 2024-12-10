extends Button

@onready var game_manager: Node = %game_manager
@onready var button_click: AudioStreamPlayer2D = $"../button_click"

func _on_pressed() -> void:
	print("clicked")
	button_click.play()
	await button_click.finished
	game_manager.go_to_main_menu()
