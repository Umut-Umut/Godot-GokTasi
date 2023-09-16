extends Node2D

# 									NOTLAR
# Oyun acilirken ekrana ard arda tiklanirsa hepsi oyun basladiginda isleme aliniyor
# ve ayni anda birden fazla mermi atesliyor.
#
# Kopan parcalarin buyuklugune bagli olarak bir odullendirme sistemi yapilabilir.
#
# Menu gecislerine animasyon eklenebilir.
# SpaceShip, butun mermileri ayni fonksiyona baglamaktansa meteor icin bir fonksiyona baglanilabilir.
#

var GUI : GraphicUI
var GAME : Game

func _ready():
	GUI = $GUI
	GAME = $Game
