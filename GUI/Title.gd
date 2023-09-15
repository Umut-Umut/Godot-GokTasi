extends Control

signal press_start
signal press_settings
signal press_quit

func _on_Start_pressed():
	emit_signal("press_start")

func _on_Settings_pressed():
	emit_signal("press_settings")

func _on_Quit_pressed():
	emit_signal("press_quit")
