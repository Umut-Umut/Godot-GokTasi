class_name Chunk

extends RigidBody2D

onready var polygon2d : Polygon2D = $Polygon2D

#func _ready():
#	angular_velocity = 1
#	mode = RigidBody2D.MODE_STATIC


#func _process(_delta):
#	pass


func reset(pos : Vector2):
	mode = RigidBody2D.MODE_RIGID
	var state : Physics2DDirectBodyState = Physics2DServer.body_get_direct_state(self.get_rid())
	state.linear_velocity = Vector2.ZERO
	# Burayi etkinlestirince isler sapitiyor
	state.angular_velocity = 1
	state.transform = Transform2D.IDENTITY # bunu yapinca daha iyi oldu
	state.transform.origin = pos
	
	
	DebugPanel.update("Chunk Rotation", rotation)
	DebugPanel.update("Angular Dump", state.total_angular_damp)
	DebugPanel.update("Linear Dump", state.total_linear_damp)

	$Timer.start()


func _on_Timer_timeout():
#	mode = RigidBody2D.MODE_STATIC
	queue_free()
