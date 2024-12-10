extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var root: Node = $"../.."
@onready var game_manager: Node = %game_manager
@onready var dialogue: CanvasLayer = %dialogue
@onready var button_click: AudioStreamPlayer = $button_click

var can_click_pause_menu = false

func resume():
	get_tree().paused = false
	can_click_pause_menu = false
	animation_player.play_backwards("blur")

func pause():
	dialogue.hide_textbox()
	can_click_pause_menu = true
	get_tree().paused = true
	animation_player.play("blur")
	
func testEsc():
	if game_manager.is_cutscene:
		# Cannot pause during a cutscene.
		return
	if Input.is_action_just_pressed("esc") && get_tree().paused == false:
		print("pausing")
		
		button_click.play()
		pause()
		await button_click.finished
	elif Input.is_action_just_pressed("esc") && get_tree().paused == true:
		print("resuming")
		button_click.play()
		resume()
		await button_click.finished
	
func _on_resume_pressed() -> void:
	if can_click_pause_menu:
		print("pressed resume")
		button_click.play()
		await button_click.finished
		resume()
	
func _on_restart_pressed() -> void:
	if can_click_pause_menu:
		print("pressed restart")
		button_click.play()
		await button_click.finished
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	if can_click_pause_menu:
		print("pressed quit")
		button_click.play()
		await button_click.finished
		get_tree().paused = false
		game_manager.go_to_main_menu()

func _ready():
	animation_player.play("RESET")

func _process(delta: float):
	testEsc()
