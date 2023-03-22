extends StaticBody2D


onready var node_bullets : Node2D = $Bullets
onready var scene_bullet := preload("res://Bullet/Bullet.tscn").instance()
onready var timer_fire = $TimerFire


var bullets : Array = []
var bullet_count : int = 0
var bullet_collector : int = 0
var bullets_size : int = 50


var is_fire : bool = false


func _ready():
	var bullet : Bullet
	for _i in range(bullets_size):
		bullet = scene_bullet.duplicate()
		node_bullets.add_child(bullet)
		bullets.append(bullet)


func _input(event):
	if event is InputEventScreenTouch:
		if is_fire and event.is_pressed():
			bullets[bullet_count].fire(Vector2.UP, global_position)
			bullet_count += 1
			bullet_count %= bullets_size
			
#			is_fire = false


func set_process(state : bool):
	.set_process(state)
	
#	is_fire = false
#	timer_fire.paused = not state
#	if state:
#		timer_fire.start()
	is_fire = state
	if is_fire:
		timer_fire.start()
	for b in bullets:
		b.set_process(state)


func _on_TimerFire_timeout():
	is_fire = true
