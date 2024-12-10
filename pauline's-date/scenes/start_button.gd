extends Button

@onready var game_manager: Node = %game_manager
@onready var button_click: AudioStreamPlayer = $"../button_click"

func _ready():
	print("start is here!")

func _on_pressed() -> void:
	button_click.play()
	await button_click.finished
	game_manager.switch_to_level_0()
