extends Area2D

@onready var game_manager: Node = %game_manager
@onready var dialogue: CanvasLayer = %dialogue

func _ending_cutscene():
	await dialogue.enqueue_text([
		"You look gorgeous Pauline!",
		"Let's check out the rest of this art gallery now :)"].map(func(txt): return "Derrick: %s" % txt))
	await dialogue.drain_text_queue()
	game_manager.switch_to_credits()
	

func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if (body.name.contains("pauline")):
		_ending_cutscene()
		
