extends Node

@onready var points_label: Label = %PointsLabel

var points = 0
var dialogue_is_active = false
var level = PlayerState.level
var is_cutscene = false

func _ready():
	print("Level is: %d" % level)

func add_points():
	points += 1
	print(points)
	match level:
		0:
			points_label.text = "Flowers: " + str(points)
		1:
			points_label.text = "Coins: " + str(points)

func switch_to_level_1():
	PlayerState.level = 1
	get_tree().call_deferred("change_scene_to_file", "res://level1.tscn")
	
func switch_to_level_2():
	PlayerState.level = 2
	get_tree().call_deferred("change_scene_to_file", "res://level2.tscn")

func mark_dialogue_active():
	dialogue_is_active = true
	
func mark_dialogue_inactive():
	dialogue_is_active = false
	
func start_cutscene():
	is_cutscene = true
	
func end_cutscene():
	is_cutscene = false
