extends Area2D

@onready var dialogue: CanvasLayer = %dialogue


var scene = 0
var scene_to_text = {
	0: "Pauline! You need to collect 20 flowers for your date!",
	1: "Come on Pauline, hurry up!"
}


func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		print("entered on scene %d" % scene)
		dialogue.add_text("Minh-Chau: %s" % scene_to_text[scene])
		scene = (scene + 1) % scene_to_text.size()

func _on_collision_shape_2d_body_exited(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		print("exited")
		dialogue.hide_textbox()
