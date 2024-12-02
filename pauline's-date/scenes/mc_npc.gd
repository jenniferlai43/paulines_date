extends Area2D

@onready var dialogue: CanvasLayer = %dialogue

func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		print("entered")
		dialogue.add_text("Minh-Chau: Pauline! You need to collect 20 flowers for your date!")

func _on_collision_shape_2d_body_exited(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		print("exited")
		dialogue.hide_textbox()
