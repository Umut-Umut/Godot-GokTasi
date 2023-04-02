extends CanvasLayer


class_name GraphicUI


signal start_game
signal game_over
signal return_menu
signal screen_touch


onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver


onready var menus : Array = []

var state_current : Control


func _ready():
	connect("game_over", self, "_on_game_over")
	
	for child in get_children():
		if child.get_class() == "Control":
			menus.append(child)

	update(title)


func update(state : Control):
	for m in menus:
		if m == state:
			m.show()
			state_current = m
		else:
			m.hide()


func _on_Settings_button_down():
	update(settings)


func _on_ReturnTitle_button_down():
	update(title)
	emit_signal("return_menu")


func _on_game_over():
	update(gameover)


func _on_CanvasEmptyTouch_button_down():
	if state_current == title:
		update(ingame)
		emit_signal("start_game")
	elif state_current == gameover:
		update(title)
		emit_signal("return_menu")
	else:
		emit_signal("screen_touch")


func _on_Quit_button_down():
	get_tree().quit()
