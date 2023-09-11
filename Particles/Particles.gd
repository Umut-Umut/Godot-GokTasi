extends Node2D


onready var particle_fire = $FireParticle/Fire
onready var particle = CPUParticles2D.new()
var fire_particles : Array = []
var particles : Array = []
var particle_iter : int = 0
var fire_particle_iter : int = 0
var temp_particle : CPUParticles2D


func _ready():
	particle.emitting = false
	particle.one_shot = true
	particle.amount = 16
	particle.linear_accel = -80
	particle.linear_accel_random = true
	particle.direction = Vector2.DOWN
	particle.spread = 180
	particle.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particle.emission_sphere_radius = 5
	particle.scale *= 3
	particle.scale_amount_random = true
	particle.lifetime = 5
	particle.lifetime_randomness = true
	particle.explosiveness = true
	particle.initial_velocity = 60
	particle.initial_velocity_random = true
	particle.z_index = 1
	particle.modulate = Color.lightsteelblue
	
	particle_fire.emitting = false
	particle_fire.one_shot = true
	
	for _i in range(50):
		var p = particle.duplicate()
#		var f = particle_fire.duplicate()
		particles.append(p)
#		fire_particles.append(f)
		add_child(p)
#		add_child(f)


func set_particle(pos : Vector2):
	temp_particle = particles[particle_iter]
	particle_iter += 1
	particle_iter %= 50
	temp_particle.position = pos
	temp_particle.restart()

#func set_fire_particle(pos : Vector2):
#	var f = fire_particles[fire_particle_iter]
#	fire_particle_iter = (fire_particle_iter + 1) % 50
#	f.position = pos
#	f.restart()
