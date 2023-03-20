extends KinematicBody2D


class_name Bullet


onready var node_collision = $CollisionShape2D


var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var speed : int = 300
var start_pos : Vector2


func _ready():
	hide()
	set_process(false)


func _process(_delta : float):
	velocity = direction * speed
	velocity = move_and_slide(velocity)


func fire(_direction : Vector2, _position : Vector2):
	direction = _direction
	global_position = _position
	start_pos = _position
	
	show()
	set_process(true)
	node_collision.set_deferred("disabled", false)

func disable():
	node_collision.set_deferred("disabled", true)
	
	hide()
	set_process(false)
