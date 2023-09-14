extends Control

signal settings_change(new_settings)
signal _return

onready var radius_slider = $VBoxContainer/Radius/HSliderRad
onready var side_slider = $VBoxContainer/SideNum/HSliderSide
onready var radius_slider_label = $VBoxContainer/Radius/SlideValue
onready var side_slider_label = $VBoxContainer/SideNum/SlideValue
onready var timer_change : Timer = $change_timer


var is_settings_change : bool = false
var settings_data : Dictionary


func _ready():
#	if connect("settings_change", get_parent(), "_on_settings_change"): pass
	
	
	var radius = radius_slider.value
	var side = side_slider.value

	settings_data["radius"] = radius
	settings_data["side"] = side
	
	if load_data():
		yield(get_tree().current_scene, "ready")
		emit_signal("settings_change", settings_data)

	radius_slider_label.text = str(settings_data["radius"])
	radius_slider.value = settings_data["radius"]
	side_slider_label.text = str(settings_data["side"])
	side_slider.value = settings_data["side"]


func _on_HSliderRad_value_changed(value):
	radius_slider_label.text = str(value)
	settings_data["radius"] = value

	emit_signal("settings_change", settings_data)
#	is_settings_change = true
#	if timer_change.is_stopped():
#		timer_change.start()


func _on_HSliderSide_value_changed(value):
	side_slider_label.text = str(value)	
	settings_data["side"] = value

	emit_signal("settings_change", settings_data)
#	is_settings_change = true
#	if timer_change.is_stopped():
#		timer_change.start()


func _on_change_timer_timeout():
	pass
#	if is_settings_change:
#	emit_signal("settings_change", settings_data)
#		is_settings_change = false
	
#	timer_change.stop()

func save_data():
	var data_file = File.new()
	data_file.open("user://data.json", File.WRITE)
	data_file.store_string(to_json(settings_data))
	data_file.close()

func load_data() -> bool:
	var data_file = File.new()
	if not data_file.file_exists("user://data.json"):
		return false

	data_file.open("user://data.json", File.READ)
	var data = data_file.get_as_text()
	settings_data = JSON.parse(data).result
	data_file.close()

	return true


func hide():
	.hide()
	timer_change.stop()


func _on_ReturnTitle_pressed():
	save_data()
	emit_signal("_return")
