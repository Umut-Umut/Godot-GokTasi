extends Node2D


onready var gui_scene = preload("res://GUI/GUI.tscn")
onready var game_scene = preload("res://Game/Game.tscn")


var GUI : GraphicUI
var GAME : Game


var is_connect_all : bool = true


func _ready():
	GUI = gui_scene.instance()
	GAME = game_scene.instance()
	
	# SIGNAL CONNECTS
	var signals = [
		"meteor_destroyed",
		"start_game",
		"return_menu",
		"screen_touch",
		"state_change",
	]
	var signal_targets = [
		self
	]
	var signal_funcs = [
		"_on_"
	]
	
	var signal_name; var signal_target; var signal_func
	for i in range(signals.size()):
		signal_name = signals[i]
		signal_target = signal_targets[i % signal_targets.size()]
		signal_func = signal_funcs[i % signal_funcs.size()] + signal_name
		if not GUI.has_signal(signal_name):
			continue
		if not GUI.connect(signal_name, signal_target, signal_func):
			DebugPanel.update("connect error | Main | _ready | %s" % signal_name, [signal_target, signal_func])
	
	
#	if not GAME.connect("meteor_destroyed", self, "_meteor_destroyed"): is_connect_all = false
#	if not GUI.connect("start_game", self, "_start_game"): 				is_connect_all = false
#	if not GUI.connect("return_menu", self, "_return_menu"): 			is_connect_all = false
#	if not GUI.connect("screen_touch", self, "_screen_touch"): 			is_connect_all = false
#	if not GUI.connect("state_change", self, "_on_state_change"): 		is_connect_all = false
	
#	if is_connect_all == false:
#		DebugPanel.update("Main | _ready | is_connect_all", is_connect_all)
		
	#### SIGNAL CONNECTS
	
	
	add_child(GAME)
	add_child(GUI)
	
	
	GAME.reset()
	
#	GAME.set_process_input(false)


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			pass
#			DebugPanel.update("Main input", OS.get_system_time_msecs())


func _on_meteor_destroyed():
	GUI.emit_signal("over_game")


func _on_screen_touch(_state : int):
	pass
#	match state:
#		GUI.State.InGame:
#			if not GAME.is_processing_input():
#				GAME.set_process_input(true)
#			GAME._screen_touch()
#		_:
#			GAME.reset()


func _on_start_game():
#	DebugPanel.update("Start Game")
	GAME.set_process_input(true)


func _on_return_menu():
	pass
#	GAME.reset()
#	DebugPanel.update("Return Menu")
#	GAME._ready()
#	GAME.set_process_input(false)


func _on_state_change():
	DebugPanel.update("State", "Changed")
