extends Control

signal press_return

func _on_Return_pressed():
	emit_signal("press_return")
