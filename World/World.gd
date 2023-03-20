extends Node2D


onready var location_flag = preload("res://LocationFlag/LocationFlag.tscn").instance()
onready var node_flags = get_node("Flags")
var flags = []


func _ready():
	var start_location : Vector2
	var location_distance = 500

	var flag = null
	
	for i in range(4):
		for j in range(4):
			flag = location_flag.duplicate()
			
			flag.set_location(start_location * location_distance)
			
			flags.append(flag)
			
			node_flags.add_child(flag)
			
			flag.label.text = str((i * 4) + j)
			
			start_location.x += 1
		start_location.x = 0
		start_location.y += 1

#	Gui.connect("location_selected", self, "set_location")


func set_location(location_index):
	var flag = flags[location_index]
	var location = flag.get_position()
	
	$UzayGemisi.set_target(location, flag.size)
	
#	var flag = flags[location_index]
#	var size = flag.size
#
#	var location = flag.global_position + (flag.global_position.direction_to($UzayGemisi.global_position) * size)
#
#	$UzayGemisi.update_move_location(location)
#
#	Gui.update_label(Gui.label.Location, location.round())
