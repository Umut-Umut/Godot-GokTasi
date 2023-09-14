extends Node2D


# 									NOTLAR
# Oyun acilirken ekrana ard arda tiklanirsa hepsi oyun basladiginda isleme aliniyor
# ve ayni anda birden fazla mermi atesliyor.
#
# Eger Meteor icin StaticBody yerine RigidBody kullanirsam ve kopan parcalara Collision verirsem
# o zaman kopan parcalarin birbirine carpmasi vs. cok guzel olabilir.
#
# Kopan parcalarin buyuklugune bagli olarak bir odullendirme sistemi yapilabilir.
#
# Menu gecislerine animasyon eklenebilir.
#

#onready var gui_scene = preload("res://GUI/GUI.tscn")
#onready var game_scene = preload("res://Game/Game.tscn")

#signal game_over


var GUI : GraphicUI
var GAME : Game


func _ready():
	GUI = $GUI
	GAME = $Game
#	GUI = gui_scene.instance()
#	GAME = game_scene.instance()
	
	if GUI.connect("settings_change", GAME, "_on_settings_change"): pass
	if GUI.connect("return_menu", GAME, "_on_return_menu"): pass
	if GUI.connect("start_game", self, "_on_start_game"): pass
	if GAME.connect("game_over", GUI, "_on_game_over"): pass
#	if GUI.connect("settings_change", GAME, "_on_settings_change"): pass
#	if not GAME.connect("meteor_destroyed", self, "_on_meteor_destroyed"): 	pass
#	if not GUI.connect("start_game", self, "_on_start_game"): 				pass
	
#	add_child(GAME)
#	add_child(GUI)


func _on_screen_touch():
	GAME.ship_fire()


#func _on_start_game():
#	GAME.start()


#func _on_return_menu():
#	GAME.init()


#func _input(event):
#	if event is InputEventKey:
#		if event.is_pressed() and not event.is_echo() and event.scancode == KEY_ENTER:
#			DebugPanel.update("Enter", "basildi")
#			$RigidBody2D.mode = RigidBody2D.MODE_STATIC
##			$RigidBody2D.position = Vector2.ZERO
##			$RigidBody2D.set_position(Vector2.ZERO)
#			$RigidBody2D.set_deferred("position", Vector2.ZERO)
#		else:
#			DebugPanel.update("Enter", "0")

func _on_start_game(only_create_meteor : bool = false):
	if only_create_meteor:
		GAME.meteor.create_meteor()
		return
	GAME.start()

#
#func _on_game_over():
#	GUI._on_game_over()


#func _on_meteor_destroyed():
#	GAME.end()
#	GUI._on_game_over()
#	GUI.emit_signal("game_over")


#func _on_settings_change(new_settings : Dictionary):
#	GAME._on_settings_change(new_settings)

