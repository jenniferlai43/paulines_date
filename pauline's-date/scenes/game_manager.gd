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

func go_to_main_menu():
	PlayerState.level = 0
	SceneTransition.change_scene("res://scenes/main_menu.tscn")

func switch_to_level_0():
	PlayerState.level = 0
	SceneTransition.change_scene("res://scenes/level0.tscn")

func switch_to_level_1():
	PlayerState.level = 1
	SceneTransition.change_scene("res://scenes/level1.tscn")
	
func switch_to_level_2():
	PlayerState.level = 2
	SceneTransition.change_scene("res://scenes/level2.tscn")
	
func switch_to_credits():
	PlayerState.level = 3
	SceneTransition.change_scene("res://scenes/credits.tscn")

func mark_dialogue_active():
	dialogue_is_active = true
	
func mark_dialogue_inactive():
	dialogue_is_active = false
	
func start_cutscene():
	is_cutscene = true
	
func end_cutscene():
	is_cutscene = false
