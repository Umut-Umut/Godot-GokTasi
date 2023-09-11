extends KinematicBody2D


class_name SpaceShip


signal shot(collision_position)


export var is_fire : bool = true


onready var node_bullets : Node2D = $Bullets
onready var scene_bullet := preload("res://Bullet/Bullet.tscn")


var bullets : Array = []
var bullet_count : int = 0
var bullets_size : int = 50


func _ready():
	if connect("shot", get_parent(), "_on_shot"): pass
	
	var bullet : Bullet
	for _i in range(bullets_size):
		bullet = scene_bullet.instance()
		
		if bullet.connect("collision", self, "_on_bullet_collide"): pass
		
		node_bullets.add_child(bullet)
		bullets.append(bullet)


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and event.index == 0:
			fire()


func fire():
	if not is_fire: return
	
	bullets[bullet_count].enable(Vector2.UP, global_position)
	bullet_count += 1
	bullet_count %= bullets_size
	
#	GlobalParticles.set_fire_particle(position)
	
#	DebugPanel.update("Counter", bullet_count)


func set_process_input(state : bool):
	.set_process_input(state)
	
#	bullets[bullet_count - 1].disable()


# Bu neden burada? Sanirim bir deneme yaptim.
func _on_Timer_timeout():
	fire()


# INTERFACE
func clear_bullets(is_hide : bool = true):
	for b in bullets:
		if not b.is_disabled:
			b.disable(is_hide)


func _on_bullet_collide(collision_position):
	emit_signal("shot", collision_position)
