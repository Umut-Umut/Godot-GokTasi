extends StaticBody2D


onready var node_bullets : Node2D = $Bullets
onready var scene_bullet := preload("res://Bullet/Bullet.tscn").instance()


var bullets : Array = []
var bullet_count : int = 0
var bullet_collector : int = 0
var bullets_size : int = 50


func _ready():
	var bullet : Bullet
	for _i in range(bullets_size):
		bullet = scene_bullet.duplicate()
		node_bullets.add_child(bullet)
		bullets.append(bullet)


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			bullets[bullet_count].fire(Vector2.UP, global_position)
			bullet_count += 1
			bullet_count %= bullets_size
