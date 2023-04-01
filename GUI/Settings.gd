extends Control


onready var radius_slider = $VBoxContainer/Radius/HSliderRad
onready var side_slider = $VBoxContainer/SideNum/HSliderSide
onready var radius_slider_label = $VBoxContainer/Radius/SlideValue
onready var side_slider_label = $VBoxContainer/SideNum/SlideValue


var settings_data : Dictionary


func _ready():
	radius_slider_label.text = str(radius_slider.value)
	side_slider_label.text = str(side_slider.value)


func _on_HSliderRad_value_changed(value):
	radius_slider_label.text = str(value)
	
	settings_data["radius"] = value


func _on_HSliderSide_value_changed(value):
	side_slider_label.text = str(value)
	
	settings_data["side"] = value
