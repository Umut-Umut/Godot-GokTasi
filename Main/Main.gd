extends Node2D


var game_scene : Resource = null
var current_game : Node2D = null


func _ready():
	Gui.connect("game_start", self, "game_start")
	Gui.connect("game_over", self, "game_over")
	Gui.connect("return_menu", self, "return_menu")
	Gui.connect("game_continue", self, "game_continue")
	
	game_scene = load("res://Game/Game.tscn")
	current_game = game_scene.instance()
	
	add_child(current_game)


func game_start(settings_parameters : Dictionary):
	if game_scene == null:
		game_scene = load("res://Game/Game.tscn")
	
	if Engine.time_scale == 0:
		Engine.time_scale = 1
	
	if not current_game == null:
		current_game.queue_free()
		current_game = null
	
	current_game = game_scene.instance()
	add_child(current_game)
	
	current_game.settings_data = settings_parameters
	current_game.show()


func return_menu():
	Engine.time_scale = 0

func game_continue():
	Engine.time_scale = 1


func game_over(end_text : String):
	current_game.queue_free()
	current_game = null
