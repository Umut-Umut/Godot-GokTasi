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

func _on_GameArea_body_exited(body):
	# bullet meteora carptigi zaman disable ediliyor. Disable sonucu area bunu exit olarak
	# algiliyor. Tekrar disable etmemek icin is_disabled kontrolu gerceklestiriliyor.
	if body is Bullet and body.is_disabled == false:
		body.disable()

func _on_GameArea_ready():
	get_node("GameArea/CollisionShape2D").shape.extents = OS.get_screen_size()

func _on_GUI_start_game():
	start()
