extends Node2D


class_name Game


signal meteor_destroyed


onready var ship : SpaceShip = $SpaceShip
onready var meteor : Meteor = $Meteor


var is_start : bool = false


func _ready():
	if not meteor.connect("destroyed", self, "_on_meteor_destroyed"): pass
	if not ship.connect("shot", self, "_on_shot_target"): pass
	
	init()


func init():
#	if not is_start:
	meteor.create_meteor()
	ship.is_fire = false


func start():
	is_start = true
	
	ship.is_fire = true
	meteor.create_meteor()


func _on_return_menu():
	ship.is_fire = false


func end():
	ship.is_fire = false
	is_start = false


func _on_meteor_destroyed():
	emit_signal("meteor_destroyed")


func _on_shot_target(collision_position : Vector2):
	if is_start:
		meteor.explode(collision_position)
		GlobalParticles.set_particle(collision_position)


func _on_settings_change(new_settings : Dictionary):
#	DebugPanel.update("game settings", new_settings)
	meteor.new_settings(new_settings)


func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.disable()
	
	if body is Chunk:
		body.disable()
