tool
extends Control


signal state_changed(state)


export (Texture) var normal_texture = null

onready var button_menu = $ButtonMenu

var state : bool = false


func change_state():
	var self_index : int = button_menu.get_index()
	state = not state
	for i in range(get_child_count()):
		if i == self_index: continue
		
		get_child(i).visible = state


func _on_ButtonMenu_pressed():
	change_state()
	emit_signal("state_changed", state)
