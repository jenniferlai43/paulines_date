extends Node

@onready var points_label: Label = %PointsLabel

var points = 0

func add_points():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
