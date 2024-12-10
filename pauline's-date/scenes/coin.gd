extends Area2D

@onready var game_manager: Node = %game_manager
@onready var collect_sfx: AudioStreamPlayer = $"../collect_sfx"


func _on_body_entered(body: Node2D) -> void: 
	if (body.name == "pauline_mc"):
		if not visible:
			# Bug happens if character entered area again
			# before item is freed from queue.
			return
			
		collect_sfx.play()
		hide()
		game_manager.add_points()
		await collect_sfx.finished
		queue_free()
