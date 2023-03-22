extends RigidBody2D


var speed : float = 1


func _ready():
	set_deferred("angular_velocity", speed)


func _on_Timer_timeout():
	queue_free()
