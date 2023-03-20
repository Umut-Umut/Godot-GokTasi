extends CanvasLayer


class_name DPanel


var hBoxContainer = HBoxContainer.new()
var labels = PanelContainer.new()
var titles = VBoxContainer.new()
var values = VBoxContainer.new()


var title_labels : Dictionary = {}


func _ready() -> void:
	titles.modulate = Color.green
	
	add_child(labels)
	labels.add_child(hBoxContainer)
	hBoxContainer.add_child(titles)
	hBoxContainer.add_child(values)


func update(_title : String, _value) -> void:
	if not title_labels.has(_title):
		var title_label := Label.new()
		var value_label := Label.new()
		
		title_label.text = _title
		title_labels[_title] = value_label
		
		titles.add_child(title_label)
		values.add_child(value_label)

	
	title_labels[_title].text = str(_value)
