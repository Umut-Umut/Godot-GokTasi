extends KinematicBody2D


class_name Bullet


signal collision(collision)


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
		disable()
		emit_signal("collision", collide)
#		collide.collider.collision(collide.position)


func enable(_direction : Vector2, _position : Vector2):
	direction = _direction
	global_position = _position
	start_pos = _position
	
	show()
	
	if node_collision.disabled:
		node_collision.set_deferred("disabled", false)
	
	is_disabled = false
	
	$Timer.start()
	
	set_deferred("physics_process", true)
#	set_physics_process(true)


func disable(is_hide : bool = true):
	if is_hide:
		hide()

	if not node_collision.disabled:
#		node_collision.disabled = true
		node_collision.set_deferred("disabled", true)
	
	is_disabled = true
	$Timer.stop()

	set_deferred("physics_process", false)
#	set_physics_process(not is_hide)


func _on_Timer_timeout():
	disable()
