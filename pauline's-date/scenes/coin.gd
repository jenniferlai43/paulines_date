extends Area2D

@onready var game_manager: Node = %game_manager

func _on_body_entered(body: Node2D) -> void: 
	print("enter")
	if (body.name.contains("pauline")):
		print("enter is pauline")
		queue_free()
		game_manager.add_points()
