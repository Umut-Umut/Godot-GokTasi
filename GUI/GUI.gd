extends CanvasLayer


class_name GraphicUI


signal start_game
#signal game_over
#signal return_menu
#signal screen_touch


onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver


onready var menus : Array = []

var state : Control


func _ready():
#	connect("game_over", self, "_on_game_over")
	
	for child in get_children():
		if child.get_class() == "Control":
			menus.append(child)

	update(title)


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and event.index == 0:
			# unhandled_input, sinyallerden sonra cagiriliyor
			if not state == ingame: # Oyun baslar baslamaz gemi ates etmesin diye
				get_tree().set_input_as_handled()
			if state == title:
				update(ingame)


func update(new_state : Control):
	for m in menus:
		if m == new_state:
			m.show()
			state = m
		else:
			m.hide()


func _on_Settings_button_down():
	update(settings)


func _on_ReturnTitle_button_down():
	update(title)
	
#	emit_signal("return_menu")


func _on_game_over():
	update(gameover)


func _on_Quit_button_down():
	get_tree().quit()
