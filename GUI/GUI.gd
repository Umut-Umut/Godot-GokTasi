extends CanvasLayer


class_name GraphicUI


signal start_game
#signal return_game
#signal settings
#signal return_menu
#signal over_game
signal screen_touch(state)
signal state_change


#onready var title = $Title
#onready var settings = $Settings
#onready var ingame	= $InGame
#onready var gameover = $GameOver

onready var anim_player := $AnimationPlayer
onready var menus := get_children()
onready var screen_size : Vector2 = OS.get_screen_size()


var is_connect_all : bool = true


enum State {
	Title,
	Settings,
	GameOver,
	InGame,
}


#var dont_touch_area : Vector2
var state : int = State.Title
var state_button : TextureButton
var is_state_change : bool = true
#var state_buttons : Dictionary
#var state_temp : int


func _ready():
#	if not connect("over_game", self, "_over_game"): pass
	if not connect("screen_touch", self, "_on_screen_touch"): pass
	if not anim_player.connect("animation_finished", self, "_on_anim_finish"): pass
	
	update()

#	for chield in get_children():
#		for c in chield.get_children():
#			if c.get_child_count() > 0:
#				for cc in c.get_children():
#					if not cc is TextureButton:
#						cc.mouse_filter = Control.MOUSE_FILTER_IGNORE
#					else:
#						cc.mouse_filter = Control.MOUSE_FILTER_STOP
#
#			if not c is TextureButton:
#				c.mouse_filter = Control.MOUSE_FILTER_IGNORE
#			else:
#				c.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	
#	for child in get_children():
#		for c in child.get_children():
#			if c is TextureButton:
#				state_buttons[c.get_parent().get_index()] = c
	
#	hide_menues()
#	title.show()
#	state = State.Title
#	state_temp = state

#	var ingame_return_button : TextureButton = menus[State.InGame].get_button_return_title()
#	dont_touch_area = ingame_return_button.rect_position + (ingame_return_button.rect_size * Vector2(0, 1))


func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			check_state_change(event.position)
			if is_state_change:
				anim_player.play("state_change")
				yield(anim_player, "animation_finished")
				update()
				anim_player.play_backwards("state_change")
				yield(anim_player, "animation_finished")
			
			emit_signal("screen_touch", state)

#				yield(get_tree().create_timer(0.1), "timeout")
#
#				update()
#				emit_signal("state_change")
#
#			emit_signal("screen_touch", state)
#			DebugPanel.update("Gui gui_input", OS.get_system_time_msecs())


# Eger cocuk dugumlerden herhangi birisine denk geliyorsa yani tiklaniyorsa is+state_change i true yapar.
func check_state_change(event_position : Vector2):
	for child in menus[state].get_children():
		if menus[state].visible == false:
			break
		if child.visible == false:
			continue
		if child.get_child_count() > 0:
			for c in child.get_children():
				if c.visible == false:
					continue
				if LibTextureButton.has_point(c, event_position):
					is_state_change = true
					state_button = c
					break
		
		if is_state_change:
			break
		if LibTextureButton.has_point(child, event_position):
			is_state_change = true
			state_button = child
			break


func update():
#	if state == state_temp:
#		return
	for menu in menus.size():
		if menu >= State.size():
			continue
		if menu == state:
			menus[menu].show()
		else:
			menus[menu].hide()
	



#func _on_Start_pressed():
##	hide_menues()
#
##	ingame.show()
#
#	emit_signal("start_game")
#
#	state = State.InGame


#func _on_Settings_pressed():
#	DebugPanel.update("settings")
##	hide_menues()
#
##	settings.show()
#	state = State.Settings


func _on_Settings_button_down():
	state = State.Settings


func _on_ReturnTitle_pressed():
#	hide_menues()
#	title.show()
	state = State.Title
	
#	emit_signal("return_menu")
#	DebugPanel.update("Gui return title", OS.get_system_time_msecs())


func _on_ReturnTitle_button_down():
	state = State.Title


func _over_game():
#	hide_menues()
	
#	gameover.show()	
	state = State.GameOver


func _on_Quit_pressed():
	get_tree().quit()


func _on_anim_finish(_anim_name : String):
	emit_signal("state_change")
	anim_player.root_node = menus[state].get_path()
#	anim_player.set_deferred("root_node", menus[state])


func _on_screen_touch(p_state : int):
	if p_state == State.Title:
		DebugPanel.update("emit start")
		emit_signal("start_game")
	DebugPanel.update("screen_touch")

















































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



