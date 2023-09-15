extends Control

signal press_return

#func show_message(msg : String):
#	$VBoxContainer/Title.text = msg

func _on_ReturnTitle_pressed():
	emit_signal("press_return")

func show():
	.show()
	$ReturnTimer.start()

func _on_ReturnTimer_timeout():
	emit_signal("press_return")
