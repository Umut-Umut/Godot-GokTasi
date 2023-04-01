extends Node2D


onready var gui_scene = preload("res://GUI/GUI.tscn")
onready var game_scene = preload("res://Game/Game.tscn")


var GUI : GraphicUI
var GAME : Game


func _ready():
	GUI = gui_scene.instance()
	GAME = game_scene.instance()
	
	
	GAME.connect("meteor_destroyed", self, "_meteor_destroyed")
	GUI.connect("start_game", self, "_start_game")
	GUI.connect("return_menu", self, "_return_menu")
	GUI.connect("screen_touch", self, "_screen_touch")
	
	
	add_child(GAME)
	add_child(GUI)
	
	
	GAME.reset()
	
#	GAME.set_process_input(false)


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			DebugPanel.update("Main input", OS.get_system_time_msecs())


func _meteor_destroyed():
	GUI.emit_signal("over_game")


func _screen_touch(state : int):
	match state:
		GUI.State.InGame:
			if not GAME.is_processing_input():
				GAME.set_process_input(true)
			GAME._screen_touch()
		_:
			GAME.reset()


func _start_game():
	pass
#	DebugPanel.update("Start Game")
#	GAME.set_process_input(true)


func _return_menu():
	pass
#	GAME.reset()
#	DebugPanel.update("Return Menu")
#	GAME._ready()
#	GAME.set_process_input(false)
