extends StaticBody2D


onready var label = get_node("Label")


var location : Vector2
var size : Vector2 = Vector2.ONE * 64 * 2


func set_location(new_location : Vector2):
	location = new_location
	global_position = new_location


func get_location():
	return location
