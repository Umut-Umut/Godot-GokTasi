extends Node2D

class_name Game

signal game_over

onready var ship : SpaceShip = $SpaceShip
onready var meteor : Meteor = $Meteor

func _ready():
	init()

func init():
	meteor.create_meteor()

func start():
	meteor.create_meteor()

func end():
	emit_signal("game_over")

func _on_Meteor_destroyed():
	end()	

func _on_BulletTravelLimit_body_entered(body):
	if body is Bullet:
		body.disable()

func _on_SpaceShip_shot(collision_position):
	meteor.explode(collision_position)
	GlobalParticles.set_particle(collision_position)

func _on_GUI_settings_change(new_settings):
	meteor.new_settings(new_settings)
