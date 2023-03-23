extends KinematicBody2D


class_name Bullet


onready var node_collision = $CollisionShape2D


export var speed : int = 100


var velocity : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
#var speed : int = 300
var start_pos : Vector2


var is_disabled : bool


func _ready():
	disable()


func _physics_process(_delta : float):
	velocity = direction * speed
	velocity = move_and_slide(velocity)


func fire(_direction : Vector2, _position : Vector2):
	direction = _direction
	global_position = _position
	start_pos = _position
	
	set_process(true)
	node_collision.set_deferred("disabled", false)
	show()
	
	is_disabled = false


func disable(is_hide : bool = true):
	if is_hide: hide()
	node_collision.set_deferred("disabled", true)
	set_process(false)
	
	is_disabled = true
