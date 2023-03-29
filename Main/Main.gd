extends Node2D


onready var gui_scene = preload("res://GUI/GUI.tscn")
onready var game_scene = preload("res://Game/Game.tscn")


var GUI : GraphicUI
var GAME : Node2D


func _ready():
	GUI = gui_scene.instance()
	GAME = game_scene.instance()
	
	
	GAME.connect("meteor_destroyed", self, "_meteor_destroyed")
	GUI.connect("start_game", self, "_start_game")
	GUI.connect("return_menu", self, "_return_menu")
	GUI.connect("screen_touch", GAME, "_screen_touch")
	
	
	add_child(GAME)
	add_child(GUI)
	
	
	GAME.set_process_input(false)


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and GUI.state == GUI.State.InGame:
			DebugPanel.update("Main input")


func _meteor_destroyed():
	GUI.emit_signal("over_game")


func _start_game():
	GAME.set_process_input(true)


func _return_menu():
	GAME._ready()
	GAME.set_process_input(false)
