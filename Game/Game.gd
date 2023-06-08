extends Node2D


class_name Game


signal meteor_destroyed


onready var ship : SpaceShip = $SpaceShip
onready var meteor = $Meteor


var is_start : bool = false


func _ready():
	if not meteor.connect("destroyed", self, "_on_meteor_destroyed"): pass
	if not ship.connect("shot", self, "_on_shot_target"): pass
	
	init()


func init():
	if not is_start:
		meteor.create_meteor()


func start():
	is_start = true


func end():
	is_start = false



func _on_meteor_destroyed():
	emit_signal("meteor_destroyed")


func _on_shot_target(collision : KinematicCollision2D):
	if is_start:
		meteor.explode(collision.position)


#func ship_fire():
#	ship.fire()

#func set_process_input(state : bool):
#	.set_process_input(state)
#	for c in get_children():
#		c.set_process_input(state)


#func _on_screen_touch():
#	pass
#	if is_start:
#		if ship.is_fire:
#			ship.fire()
#		else:
#			ship.is_fire = true


func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.disable()
	
	if body is Chunk:
		body.disable()
