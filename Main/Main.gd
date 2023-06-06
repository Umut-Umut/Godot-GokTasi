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
# Gercek zamanli olarak ayarlar uzerinde yapilan degisiklikler arkaplanda meteora uygulanabilir.
#
# Menu gecislerine animasyon eklenebilir.
# 
# Meteor un icine giren mermiler icin kontrol etmeyi unutma.
#

# 									COZULENLER
# Hala polygon un gorunmez olmasi gibi hatalar soz konusu. Kodu temizleyince umarim duzelir.
# Sanirim ayni anda birden fazla parcanin dusurulebilmesiyle bu sorun duzeldi.
#
# Geometry.triangulate_polygon fonksiyonu kullanilarak poligonlarin alani hesaplanabilir.
# veya The Shoelace Algorithm kullanilabilir. The Shoelace Algrithm daha kolay gibi.
#
# Meteor un merkezinde bir cekirdek olur ve bu cekirdekten bagi kopan parcalar dusebilir.
# En azindan kendi etrafinda donen alakasiz bir parcadansa bu daha mantikli
# Meteor a bir arkaplan poligonu ekledim. En azindan daha mantikli gorunuyor.
#


onready var gui_scene = preload("res://GUI/GUI.tscn")
onready var game_scene = preload("res://Game/Game.tscn")

var GUI : GraphicUI
var GAME : Game


func _ready():
	GUI = gui_scene.instance()
	GAME = game_scene.instance()
	
#	if not GAME.connect("meteor_destroyed", self, "_on_meteor_destroyed"): 	pass
#	if not GUI.connect("screen_touch", GAME, "_on_screen_touch"):			pass
	if not GUI.connect("start_game", self, "_on_start_game"): 				pass
#	if not GUI.connect("return_menu", self, "_on_return_menu"):				pass
#	if not GUI.connect("screen_touch", self, "_on_screen_touch"): 			pass
	
	add_child(GAME)
	add_child(GUI)


func _on_screen_touch():
	GAME.ship_fire()


func _on_start_game():
	GAME.start()


func _on_return_menu():
	GAME.init()
	

func _on_meteor_destroyed():
	GAME.end()
	GUI.emit_signal("game_over")
