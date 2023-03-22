extends Node2D


#
# Hala polygon un gorunmez olmasi gibi hatalar soz konusu. Kodu temizleyince umarim duzelir.
# Sanirim ayni anda birden fazla parcanin dusurulebilmesiyle bu sorun duzeldi.
#
# Geometry.triangulate_polygon fonksiyonu kullanilarak poligonlarin alani hesaplanabilir.
# veya The Shoelace Algorithm kullanilabilir.
#
# Eger Meteor icin StaticBody yerine RigidBody kullanirsam ve kopan parcalara Collision verirsem
# o zaman kopan parcalarin birbirine carpmasi vs. cok guzel olabilir.
#
# Meteor un merkezinde bir cekirdek olur ve bu cekirdekten bagi kopan parcalar dusebilir.
# En azindan kendi etrafinda donen alakasiz bir parcadansa bu daha mantikli
#
# Kopan parcalarin buyuklugune bagli olarak bir odullendirme sistemi yapilabilir.
#


onready var meteor = $Meteor


var settings_data : Dictionary
var is_clear : bool = true


func _ready():
	hide()
	
	Gui.connect("game_start", self, "start_game")
	Gui.connect("return_menu", self, "return_menu")
	Gui.connect("game_continue", self, "continue_game")
	
	
	meteor.connect("clear", self, "meteor_destroyed")
	
#	Gui.connect("game_over", self, "game_over")


func reset():
	pass


func start_game(settings_parameter):
	show()


func meteor_destroyed():
	Gui.emit_signal("game_over", "Göktaşını Yok Ettin...")
	hide()
	
	is_clear = true


func return_menu():
	pass
#	hide()


func continue_game():
	show(true)


func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.disable()
#		body.hide()
#		body.set_process(false)


func hide():
	.hide()
	for child in get_children():
		child.set_process(false)
		child.set_process_input(false)	


func show(is_continue : bool = false):
	if is_continue == false and is_clear:
		if settings_data.has("radius") and settings_data.has("side"):
			meteor.create_meteor(settings_data["side"], settings_data["radius"])
		else:
			meteor.create_meteor(12, 64 * 3)
	
	.show()
	for child in get_children():
		child.set_process(true)
		child.set_process_input(true)
