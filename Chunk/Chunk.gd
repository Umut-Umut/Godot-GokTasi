extends RigidBody2D


class_name Chunk


onready var polygon : Polygon2D = Polygon2D.new()

var speed : float = 1


func _ready():
	add_child(polygon)
	gravity_scale = rand_range(1, 2)
	set_deferred("angular_velocity", speed)
	
	disable()


func disable():
	hide()
#	mode = MODE_STATIC
	set_deferred("mode", MODE_STATIC)
	$CollisionShape2D.set_deferred("disabled", true)

func show():
	.show()
	$CollisionShape2D.set_deferred("disabled", false)
	set_deferred("mode", MODE_RIGID)

func _on_Timer_timeout():
	queue_free()
