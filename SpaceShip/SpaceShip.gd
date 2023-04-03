extends StaticBody2D


class_name SpaceShip


signal shot(target)


export var is_fire : bool = true


onready var node_bullets : Node2D = $Bullets
onready var scene_bullet := preload("res://Bullet/Bullet.tscn")


var bullets : Array = []
var bullet_count : int = 0
var bullets_size : int = 50


func _ready():
	var bullet : Bullet
	for _i in range(bullets_size):
		bullet = scene_bullet.instance()
		
		bullet.connect("collide", self, "_on_bullet_collide")
		
		node_bullets.add_child(bullet)
		bullets.append(bullet)


func fire():
	if not is_fire: return
	bullets[bullet_count].enable(Vector2.UP, global_position)
	bullet_count += 1
	bullet_count %= bullets_size
	
#	DebugPanel.update("Counter", bullet_count)


func set_process_input(state : bool):
	.set_process_input(state)
	
#	bullets[bullet_count - 1].disable()


func _on_Timer_timeout():
	fire()


# INTERFACE
func clear_bullets(is_hide : bool = true):
	for b in bullets:
		if not b.is_disabled:
			b.disable(is_hide)


func _on_bullet_collide(target):
	emit_signal("shot", target)
