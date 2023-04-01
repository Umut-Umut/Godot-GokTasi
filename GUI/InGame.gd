extends Control


onready var button_return_title : TextureButton = $ReturnTitle


func get_button_return_title() -> TextureButton:
	return button_return_title
func _gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
#			if event.position.y > dont_touch_area.y or event.position.x < dont_touch_area.x:
#				emit_signal("screen_touch", state)
			DebugPanel.update("InGame input", OS.get_system_time_msecs())


func _on_ReturnTitle_pressed():
	DebugPanel.update("ingame pressed", OS.get_system_time_msecs())
