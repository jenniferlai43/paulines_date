extends Area2D

@onready var game_manager: Node = %game_manager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		queue_free()
		game_manager.add_points()
