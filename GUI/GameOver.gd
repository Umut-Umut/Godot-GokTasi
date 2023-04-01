extends Control


func show_message(msg : String):
	$VBoxContainer/Title.text = msg


func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
#			if event.position.y > dont_touch_area.y or event.position.x < dont_touch_area.x:
#				emit_signal("screen_touch", state)
			DebugPanel.update("GameOVer input", OS.get_system_time_msecs())
