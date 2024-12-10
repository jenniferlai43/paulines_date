extends Area2D

@onready var game_manager: Node = %game_manager
@onready var dialogue: CanvasLayer = %dialogue


var lvl0_text_loop_idx = 0
const LVL0_TEXT_LOOP_IDX_TO_TEXT = {
	0: ["Pauline! You need to collect 10 flowers for your date!"],
	1: ["Come on Pauline, hurry up!"],
}
const LVL0_ALL_FLOWERS_ACQUIRED = [
	"Awesome! Let's go onto your date now!"
]


var lvl1_text_loop_idx = 0
const LVL1_TEXT_LOOP_IDX_TO_TEXT = {
	0: ["Girl I can't do anything with that many coins. Get me 10!"],
	1: ["Pauline, don't piss me off."],
}


func _lvl0_flowers_acquired_cutscene():
	game_manager.start_cutscene()
	dialogue.enqueue_text(["Minh-Chau: Awesome! You got the flowers. Okay, you better get going before you're late!"])
	print("Start display text")
	await dialogue.display_next_text()
	print("Finished display text")
	var mc_npc = get_node("Sprite2D")
	mc_npc.flip_h = not mc_npc.flip_h
	await get_tree().create_timer(3).timeout
	mc_npc.flip_h = not mc_npc.flip_h
	await dialogue.enqueue_text([
		"Wait. You're going in that outfit?",
		"...",
		"I'm not sure if that's...",
		"...",
		"If you can get me 10 gold coins, I can make you a new dress!"].map(func(txt): return "Minh-Chau: %s" % txt))
	await dialogue.drain_text_queue(2)
	game_manager.end_cutscene()
	game_manager.switch_to_level_1()
	
func _lvl1_coins_acquired_cutscene():
	game_manager.start_cutscene()
	dialogue.enqueue_text(["Minh-Chau: Yippee! Let's get you that dress :)"])
	await dialogue.display_next_text()
	var mc_npc = get_node("Sprite2D")
	mc_npc.flip_h = not mc_npc.flip_h
	await get_tree().create_timer(2).timeout
	game_manager.end_cutscene()
	print("SCENE TO DATE!")
	game_manager.switch_to_level_2()

func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if (body.name == "pauline_mc"):
		match game_manager.level:
			0:
				if (game_manager.points != 10):
					dialogue.enqueue_text(LVL0_TEXT_LOOP_IDX_TO_TEXT[lvl0_text_loop_idx].map(func(txt): return "Minh-Chau: %s" % txt))
					dialogue.display_next_text()
					lvl0_text_loop_idx = (lvl0_text_loop_idx + 1) % LVL0_TEXT_LOOP_IDX_TO_TEXT.size()
				else:
					_lvl0_flowers_acquired_cutscene()
					
			1:
				if (game_manager.points != 10):
					dialogue.enqueue_text(LVL1_TEXT_LOOP_IDX_TO_TEXT[lvl0_text_loop_idx].map(func(txt): return "Minh-Chau: %s" % txt))
					dialogue.display_next_text()
					lvl1_text_loop_idx = (lvl1_text_loop_idx + 1) % LVL1_TEXT_LOOP_IDX_TO_TEXT.size()
				else:
					_lvl1_coins_acquired_cutscene()
			_:
				print("Unexpected")
