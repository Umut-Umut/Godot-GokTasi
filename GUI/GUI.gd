extends CanvasLayer


class_name GraphicUI


signal start_game(only_create_meteor)
signal game_over
signal return_menu
#signal screen_touch
#signal settings_change(new_settings)


onready var title = $Title
onready var settings = $Settings
onready var ingame	= $InGame
onready var gameover = $GameOver


onready var menus : Array = []

var state_is_change : bool = false
var pre_state : Control = title
var state : Control


func _ready():
#	if settings.connect("settings_change", self, "_on_settings_change"): pass
#	if connect("settings_change", get_parent(), "_on_settings_change"): pass
	if connect("game_over", self, "_on_game_over"): pass
	
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


func _on_Start_pressed():
	update(ingame)
	emit_signal("start_game")


func _on_Settings_button_down():
	update(settings)


func _on_ReturnTitle_button_down():
	update(title)
	emit_signal("return_menu")
	
#	$GameOver/ReturnTitle.disabled = true


func _on_game_over():
	update(gameover)
	yield(get_tree().create_timer(3), "timeout")
	update(title)
	emit_signal("start_game", true)
#	$GameOver/ReturnTitle.disabled = false


func _on_settings_change(new_settings : Dictionary):
	get_parent()._on_settings_change(new_settings)
#	emit_signal("settings_change", new_settings)
#	DebugPanel.update("settings", new_settings)


func _on_Quit_button_down():
	settings.save_data()
	get_tree().quit()

func _exit_tree():
	settings.save_data()

