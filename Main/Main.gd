extends Node2D


onready var gui_scene = preload("res://GUI/GUI.tscn")
onready var game_scene = preload("res://Game/Game.tscn")

var GUI : GraphicUI
var GAME : Game

var is_start : bool = false


func _ready():
	GUI = gui_scene.instance()
	GAME = game_scene.instance()

	if not GAME.connect("meteor_destroyed", self, "_on_meteor_destroyed"): 	pass
#	if not GUI.connect("screen_touch", GAME, "_on_screen_touch"):			pass
	if not GUI.connect("start_game", self, "_on_start_game"): 				pass
	if not GUI.connect("return_menu", self, "_on_return_menu"):				pass
	if not GUI.connect("screen_touch", self, "_on_screen_touch"): 			pass
	
	add_child(GAME)
	add_child(GUI)
	
	GAME.reset()


func _on_screen_touch():
	if is_start:
		GAME.ship_fire()


func _on_start_game():
	is_start = true
	GAME.reset()


func _on_return_menu():
	is_start = false
	GAME.reset()


func _on_meteor_destroyed():
	GUI.emit_signal("game_over")
