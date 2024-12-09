extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var root: Node = $"../.."
@onready var game_manager: Node = %game_manager
@onready var dialogue: CanvasLayer = %dialogue

func resume():
	get_tree().paused = false
	animation_player.play_backwards("blur")

func pause():
	dialogue.hide_textbox()
	get_tree().paused = true
	animation_player.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("esc") && get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") && get_tree().paused == true:
		resume()
	

func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	game_manager.go_to_main_menu()

func _ready():
	animation_player.play("RESET")

func _process(delta: float):
	testEsc()
