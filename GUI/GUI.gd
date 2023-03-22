extends CanvasLayer


signal start_game
signal return_game
signal settings
signal return_menu
signal over_game


onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver


func _ready():
	connect("over_game", self, "_over_game")
	
	
	hide_menues()
	
	title.show()


func hide_menues():
	for menu in get_children():
		menu.hide()


func _on_Start_pressed():
	hide_menues()
	
	ingame.show()
	
	emit_signal("start_game")


func _on_Settings_pressed():
	hide_menues()
	
	settings.show()


func _on_ReturnTitle_pressed():
	hide_menues()
	
	title.show()

	emit_signal("return_menu")


func _over_game():
	hide_menues()
	
	gameover.show()


func _on_Quit_pressed():
	get_tree().quit()






















































#signal game_start(settings_parameters)
#signal game_over(end_text)
#signal settings(settings_parameters)
#signal exit_settings(settings_parameters)
#signal game_continue
#signal return_menu
#
#
#onready var title = $Title
#onready var settings = $Settings
#onready var gameover = $GameOver
#onready var ingame	= $InGame
#
#
#var settings_data : Dictionary
#
#
#func _ready():
#	hide_menues()
#	title.show()	
#
#	connect("game_over", self, "game_over")
#	connect("exit_settings", self, "settings_exit")
#
#
#	var data : Dictionary = load_settings()
#	if data.empty() == false:
#		settings_data = data
#
#
#func save_settings(settings_parameters : Dictionary):
#	var file = File.new()
#	if file.open("user://saves.sav", File.WRITE) == OK:
#		file.store_line(str(settings_parameters))
#		file.close()
#
#
#func load_settings() -> Dictionary:
#	var file = File.new()
#	var data : Dictionary
#	if file.open("saves.sav", File.READ) == OK:
#		data = parse_json(file.get_line())
#		file.close()
#
#	return data
#
#
#
#func _on_Start_pressed():
#	hide_menues()
#
#	ingame.show()
#	emit_signal("game_start", settings_data)
#
#
#func _on_Settings_pressed():
#	hide_menues()
#	settings.show()
#
#	emit_signal("settings", settings_data)
#
#
#func _on_Quit_pressed():
#	get_tree().quit()
#
#
#func settings_exit(settings_parameters : Dictionary):
#	settings_data = settings_parameters
#	save_settings(settings_parameters)
#
#
#func game_over(end_message : String):
#	hide_menues()
#
#	gameover.show_message(end_message)
#	gameover.show()
#
#
#func _on_Continue_pressed():
#	hide_menues()
#
#	ingame.show()
#	emit_signal("game_continue")
#
#
#func _on_ReturnTitle_pressed():
#	hide_menues()
#
#	title.show()
#
#	emit_signal("return_menu")
#
#
#func hide_menues():
#	for menu in get_children():
#		menu.hide()




















#extends CanvasLayer
#
#signal location_selected(button_index)
#
##onready var labels = get_node("Control/HBoxContainer/LabelsValue").get_children()
#onready var node_labels = get_node("Control/Labels")
#onready var node_label_title = get_node("Control/Labels/LabelsTittle")
#onready var node_label_value = get_node("Control/Labels/LabelsValue")
#onready var node_background_panel = get_node("Control/Panel")
#
#onready var buttons_location = get_node("Control/ButtonsLocation").get_children()
#
#
#var labels : Dictionary = {}
#
#
##
##enum label {
##	Speed,
##	SpeedAcc,
##	Distance,
##	Angle,
##	Rotation,
##	Location,
##	Position,
##	Velocity,
##	Break,
##}
#
#
#func _ready():
#	if buttons_location:
#		for b in buttons_location:
#			b.connect("pressed", self, "on_selected_location", [b.get_index()])
#
## l : Gui.label, value : variable
#func update_label(label_name : String, value):
#	if not labels.has(label_name):
#		var label_title = Label.new()
#		var label_value = Label.new()
#
#
#		node_label_title.add_child(label_title)
#		node_label_value.add_child(label_value)
#
#
#		labels[label_name] = label_value
#
#
#		label_title.text = label_name
#
#		update_panel_size()
#
#
#
#
#	labels[label_name].text = str(value)
#
#
#func update_panel_size():
#	node_background_panel.rect_size = node_labels.rect_size
#
#
##	if l >= 0 and l < len(labels):
##		 labels[l].text = str(value)
#
#
#func on_selected_location(button_index):
#	emit_signal("location_selected", button_index)
