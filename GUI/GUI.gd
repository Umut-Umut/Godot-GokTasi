extends CanvasLayer

class_name GraphicUI

signal start_game(only_create_meteor)
signal return_menu
signal settings_change(new_settings)

onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver

onready var menus : Array = []

var state_is_change : bool = false
var pre_state : Control = title
var state : Control

func _ready():
	for child in get_children():
		if child.get_class() == "Control":
			menus.append(child)

	update(title)

func update(new_state : Control):
	state_is_change = true
	
	for m in menus:
		if m == new_state:
			m.show()
			pre_state = state
			state = m
		else:
			m.hide()

func _on_Title_press_start():
	update(ingame)
	emit_signal("start_game")

func _on_Title_press_settings():
	update(settings)

func _on_Title_press_quit():
	settings.save_data()
	get_tree().quit()

func _on_Settings_press_return():
	update(title)
	emit_signal("return_menu")

func _on_InGame_press_return():
	update(title)
	emit_signal("return_menu")

func _on_game_over():
	update(gameover)

func _on_GameOver_press_return():
	update(title)
	emit_signal("start_game", true)

func _on_Settings_settings_change(new_settings):
	emit_signal("settings_change", new_settings)
