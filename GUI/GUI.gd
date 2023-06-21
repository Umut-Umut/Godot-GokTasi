extends CanvasLayer


class_name GraphicUI


signal start_game
signal game_over
signal return_menu
#signal screen_touch


onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver


onready var menus : Array = []

var state_is_change : bool = false
var state : Control


func _ready():
	if not connect("game_over", self, "_on_game_over"): pass
	
	for child in get_children():
		if child.get_class() == "Control":
			menus.append(child)

	update(title)


#func _unhandled_input(event):
#	if event is InputEventScreenTouch:
#		if event.pressed and event.index == 0:
#			if not state == ingame: # Oyun baslar baslamaz gemi ates etmesin diye
#				get_tree().set_input_as_handled()
#
#
#			if state_is_change:
#				if state == title:
#					update(ingame)
#					emit_signal("start_game")
#			if not state_is_change:
#				if state == gameover:
#					update(title)
#
#
#			state_is_change = false
			
#			if state == title:
#				update(ingame)
#				emit_signal("start_game")
#			elif state == gameover:
#				update(title)
				
				
#			if state_is_change == false and state == title:
#				update(ingame)
#				emit_signal("start_game")
#			elif state_is_change == false and state == gameover:
#				update(title)

			
#			print("Screen touch GUI.gd")
#			# unhandled_input, sinyallerden sonra cagiriliyor
#			if not state == ingame: # Oyun baslar baslamaz gemi ates etmesin diye
#				get_tree().set_input_as_handled()
#
#			if state == title:
#				update(ingame)
#				emit_signal("start_game")
#
#			if state == gameover:
#				update(title)


func update(new_state : Control):
	state_is_change = true
	
	for m in menus:
		if m == new_state:
			m.show()
			state = m
		else:
			m.hide()


func _on_Start_pressed():
	update(ingame)
	emit_signal("start_game")


func _on_Settings_button_down():
	update(settings)


func _on_ReturnTitle_button_down():
	update(title)
	emit_signal("return_menu")


func _on_game_over():
	update(gameover)


func _on_Quit_button_down():
	get_tree().quit()
