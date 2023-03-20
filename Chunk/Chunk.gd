extends RigidBody2D


var speed : float = 1


func _ready():
#	angular_velocity = speed
	set_deferred("linear_velocity", 300)
	set_deferred("angular_velocity", speed)
