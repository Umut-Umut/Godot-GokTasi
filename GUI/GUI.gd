extends CanvasLayer

signal location_selected(button_index)

#onready var labels = get_node("Control/HBoxContainer/LabelsValue").get_children()
onready var node_labels = get_node("Control/Labels")
onready var node_label_title = get_node("Control/Labels/LabelsTittle")
onready var node_label_value = get_node("Control/Labels/LabelsValue")
onready var node_background_panel = get_node("Control/Panel")

onready var buttons_location = get_node("Control/ButtonsLocation").get_children()


var labels : Dictionary = {}


#
#enum label {
#	Speed,
#	SpeedAcc,
#	Distance,
#	Angle,
#	Rotation,
#	Location,
#	Position,
#	Velocity,
#	Break,
#}


func _ready():
	if buttons_location:
		for b in buttons_location:
			b.connect("pressed", self, "on_selected_location", [b.get_index()])

# l : Gui.label, value : variable
func update_label(label_name : String, value):
	if not labels.has(label_name):
		var label_title = Label.new()
		var label_value = Label.new()
		
		
		node_label_title.add_child(label_title)
		node_label_value.add_child(label_value)
		
		
		labels[label_name] = label_value
		
		
		label_title.text = label_name
		
		update_panel_size()
				
		
		

	labels[label_name].text = str(value)


func update_panel_size():
	node_background_panel.rect_size = node_labels.rect_size
		
		
#	if l >= 0 and l < len(labels):
#		 labels[l].text = str(value)


func on_selected_location(button_index):
	emit_signal("location_selected", button_index)
