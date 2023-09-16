extends CanvasLayer

class_name GraphicUI

signal press_start
signal press_return
signal settings_change(new_settings)

onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver

var menus : Array = []

func _ready():
	menus = get_children()
	update(title)

func update(new_state : Control):
	for m in menus:
		if m == new_state:
			m.show()
		else:
			m.hide()

func _on_Title_press_start():
	update(ingame)
	emit_signal("press_start")

func _on_Title_press_settings():
	update(settings)

func _on_Title_press_quit():
	settings.save_data()
	get_tree().quit()

func _on_Settings_press_return():
	update(title)
	emit_signal("press_return")

func _on_InGame_press_return():
	update(title)
	emit_signal("press_return")

func _on_GameOver_press_return():
	update(title)
	emit_signal("press_start")

func _on_Settings_settings_change(new_settings):
	emit_signal("settings_change", new_settings)

func _on_Game_game_over():
	update(gameover)
