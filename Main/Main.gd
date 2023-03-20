extends Node2D


#
# Hala polygon un gorunmez olmasi gibi hatalar soz konusu. Kodu temizleyince umarim duzelir.
# Tek seferde 2 parca dusurmeye calistigimda parcalar yok oldu. Cunku clip_polygon un boyutu
# 3 oldugunda kontrollerin hicbirine girmiyor.
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


func _ready():
	pass


func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.hide()
		body.set_process(false)
