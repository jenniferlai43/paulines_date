extends CanvasLayer

@onready var game_manager: Node = %game_manager

@onready var textbox_container: MarginContainer = $textbox_container
@onready var start: Label = $textbox_container/MarginContainer/HBoxContainer/Start
@onready var end: Label = $textbox_container/MarginContainer/HBoxContainer/End

@onready var text: Label = $textbox_container/MarginContainer/HBoxContainer/Text

var text_queue = []

func _ready():
	hide_textbox()
	#add_text("This text is going to be added!")
	
	
func hide_textbox():
	text_queue = []
	start.text = ""
	text.text = ""
	textbox_container.hide()
	game_manager.mark_dialogue_inactive()
	
func show_textbox():
	start.text = "*"
	if (game_manager.is_cutscene == true):
		end.text = "[Cannot skip]"
	else:
		end.text = "[E] to exit"
	textbox_container.show()
	game_manager.mark_dialogue_active()

# Enqueue an arrray of texts. display_text() will pop off queue until there are none left.
func enqueue_text(text_arr):
	text_queue.append_array(text_arr)

func drain_text_queue():
	while not text_queue.is_empty():
		await display_next_text()

func display_next_text():
	if not text_queue.is_empty():
		text.text = text_queue.pop_front()
		text.visible_characters = 0
		show_textbox()
		var tween = get_tree().create_tween()
		print("starting")
		await tween.tween_property(text, "visible_characters", 100, 2).from(0).finished
		print("tween finished")
	else:
		# If no text is left, we can hide the textbox now.
		hide_textbox()
	print("display_next_text is finished")
