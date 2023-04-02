extends Node2D


class_name Game


signal meteor_destroyed


#
# Hala polygon un gorunmez olmasi gibi hatalar soz konusu. Kodu temizleyince umarim duzelir.
# Sanirim ayni anda birden fazla parcanin dusurulebilmesiyle bu sorun duzeldi.
#
# Geometry.triangulate_polygon fonksiyonu kullanilarak poligonlarin alani hesaplanabilir.
# veya The Shoelace Algorithm kullanilabilir. The Shoelace Algrithm daha kolay gibi.
#
# Eger Meteor icin StaticBody yerine RigidBody kullanirsam ve kopan parcalara Collision verirsem
# o zaman kopan parcalarin birbirine carpmasi vs. cok guzel olabilir.
#
# Meteor un merkezinde bir cekirdek olur ve bu cekirdekten bagi kopan parcalar dusebilir.
# En azindan kendi etrafinda donen alakasiz bir parcadansa bu daha mantikli
#
# Kopan parcalarin buyuklugune bagli olarak bir odullendirme sistemi yapilabilir.
#
# Gercek zamanli olarak ayarlar uzerinde yapilan degisiklikler arkaplanda meteora uygulanabilir.
#


onready var ship : SpaceShip = $SpaceShip
onready var meteor = $Meteor

#var is_start : bool = false


func _ready():
	if meteor.is_connected("destroyed", self, "_meteor_destroyed") == false:
		meteor.connect("destroyed", self, "_meteor_destroyed")


func reset():
	if meteor.is_destroyed or not meteor.is_created:
#		ship.clear_bullets(false)
		meteor.create_meteor()
	elif meteor.is_created:
		pass
#		ship.clear_bullets(false)


func _meteor_destroyed():
	emit_signal("meteor_destroyed")
	
#	ship.clear_bullets(false)


func ship_fire():
	ship.fire()

#func set_process_input(state : bool):
#	.set_process_input(state)
#	for c in get_children():
#		c.set_process_input(state)


#func _on_screen_touch():
#	pass
#	if is_start:
#		if ship.is_fire:
#			ship.fire()
#		else:
#			ship.is_fire = true


func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.disable()
	
	if body is Chunk:
		body.disable()
