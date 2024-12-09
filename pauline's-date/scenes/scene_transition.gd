extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene(target: String) -> void:
	animation_player.play('dissolve')
	await animation_player.animation_finished
	print("Trying to change scene to...")
	get_tree().call_deferred("change_scene_to_file", target)
	animation_player.play_backwards('dissolve')
