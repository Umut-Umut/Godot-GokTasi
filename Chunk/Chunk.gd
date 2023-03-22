extends RigidBody2D


class_name Chunk


var speed : float = 1


func _ready():
	set_deferred("angular_velocity", speed)


func disable():
	hide()
	set_deferred("mode", RigidBody2D.MODE_STATIC)


func _on_Timer_timeout():
	queue_free()
