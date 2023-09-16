extends KinematicBody2D

class_name SpaceShip

signal shot(collision_position)

onready var node_bullets : Node2D = $Bullets
onready var scene_bullet := preload("res://Bullet/Bullet.tscn")

var bullets : Array = []
var bullet_count : int = 0
var bullets_size : int = 50

func _ready():
	var bullet : Bullet
	for _i in range(bullets_size):
		bullet = scene_bullet.instance()
		
		if bullet.connect("collision", self, "_on_bullet_collide"): pass
		
		node_bullets.add_child(bullet)
		bullets.append(bullet)

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and event.index == 0:
			DebugPanel.update("Ship Fire")
			fire()

func fire():
	bullets[bullet_count].enable(Vector2.UP, global_position)
	bullet_count += 1
	bullet_count %= bullets_size

func _on_bullet_collide(collision_position):
	emit_signal("shot", collision_position)
