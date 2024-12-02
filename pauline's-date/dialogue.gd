extends CanvasLayer

@onready var textbox_container: MarginContainer = $textbox_container
@onready var start: Label = $textbox_container/MarginContainer/HBoxContainer/Start
@onready var end: Label = $textbox_container/MarginContainer/HBoxContainer/End

@onready var text: Label = $textbox_container/MarginContainer/HBoxContainer/Text

var CHAR_READ_RATE = 1

func _ready():
	hide_textbox()
	#add_text("This text is going to be added!")
	
func hide_textbox():
	start.text = ""
	end.text = ""
	text.text = ""
	textbox_container.hide()
	
func show_textbox():
	start.text = "*"
	textbox_container.show()

func add_text(next_text):
	text.text = next_text
	show_textbox()
	var tween = get_tree().create_tween()
	tween.tween_property(text, "visible_characters", 100, 2).from(0).finished
