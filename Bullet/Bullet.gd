extends KinematicBody2D


class_name Bullet


onready var node_collision = $CollisionShape2D


export var speed : int = 100


var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
#var speed : int = 300
var start_pos : Vector2
var collide : KinematicCollision2D


var is_disabled : bool = false


func _ready():
	disable()


func _physics_process(delta : float):
	velocity = direction * speed
	collide = move_and_collide(velocity * delta)

	if collide:
		collide.collider.collision(collide.position)
		disable()


func fire(_direction : Vector2, _position : Vector2):
	direction = _direction
	global_position = _position
	start_pos = _position
	
	show()
	
	set_physics_process(true)
	
	if node_collision.disabled:
		node_collision.set_deferred("disabled", false)
	
	is_disabled = false
	
	$Timer.start()


func disable(is_hide : bool = true):
	if is_hide:
		hide()
		set_physics_process(false)
	
	if is_disabled:
		node_collision.set_deferred("disabled", true)
	
	is_disabled = true
	$Timer.stop()


func _on_Timer_timeout():
	disable()
