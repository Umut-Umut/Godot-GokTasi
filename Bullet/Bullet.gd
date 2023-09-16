extends KinematicBody2D

class_name Bullet

signal collision(collision_position)

onready var node_collision = $CollisionShape2D

var speed : int = 500
var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var start_pos : Vector2
var collide : KinematicCollision2D

var is_disabled : bool = false

func _ready():
	disable()

func _physics_process(delta : float):
	velocity = direction * (speed * delta)
	collide = move_and_collide(velocity)

	if collide:
		disable()
		emit_signal("collision", collide.position)

func enable(_direction : Vector2, _position : Vector2):
	direction = _direction
	global_position = _position
	start_pos = _position
	
	show()
	
	if node_collision.disabled:
		node_collision.set_deferred("disabled", false)
	
	is_disabled = false
	
	set_physics_process(true)

func disable(is_hide : bool = true):
	if is_hide:
		hide()

	if not node_collision.disabled:
		node_collision.set_deferred("disabled", true)
	
	is_disabled = true

	set_physics_process(false)
