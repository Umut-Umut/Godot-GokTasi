extends KinematicBody2D


var velocity 	: Vector2
var direction	: Vector2
var target_pos	: Vector2 = Vector2(500, 500)

var angle			: float
var angle_velocity 	: float

var max_force		: float = 1000
var force			: float

var distance		: float


func _physics_process(_delta):
	update_direction()
	update_angle()
	update_rotation()
	update_distance()
	update_force()
	update_velocity()
	
	velocity = move_and_slide(velocity)


func _input(_event):
	if Input.is_action_just_pressed("ui_up"):
		force += 5
	elif Input.is_action_just_pressed("ui_down"):
		force -= 5


func update_velocity():
	velocity = Vector2.RIGHT.rotated(global_rotation)
	
	velocity *= force	


func update_direction():
	direction = global_position.direction_to(target_pos)


func update_distance():
	distance = global_position.distance_to(target_pos)


func update_force():
	if force > 0 and abs(angle_velocity) > 0:
		force = lerp(force, min(max_force, distance), force / abs(angle_velocity))

func update_angle():
	angle = direction.angle()
	angle_velocity = velocity.angle_to(direction)


func update_rotation():
	if force > 0 and distance > 0:
		global_rotation = lerp_angle(global_rotation, angle, force / max_force)





































#var velocity 	: Vector2
#
#var speed_max 	: float = 100.0
#var speed		: float = 0.0
#var speed_acc	: float = 2.0 / 60
#var speed_dec	: float = speed_acc
#var speed_rotate: float = 1.0 / 60
#
#var target		: Vector2
#var target_pos	: Vector2
#var target_size : Vector2
#
#var direction	: Vector2
#var direction_rotation : float = 0.0
#
#var distance	: float = 0.0
#var distance_f	: float = 0.0
#
#var break_dist	: float = 0.0
#
#var angle		: float = 0.0
#var angle_direction : float = 0.0
#
#var sensivity_focus : float = 0.05
#
#var slow : bool = false
#var stop : bool = true
#
#
#func _physics_process(_delta):
#	update_distance()
#	update_direction()
#	update_angle()
#
#	update_rotation()	
#
#	update_speed()
#
#
#	velocity = Vector2.RIGHT.rotated(global_rotation).normalized()
#	velocity = move_and_slide(velocity * speed)
#
##	update_target_pos()
#	update_gui()
#
#
#func update_speed():
#	if distance <= 0:
#		return
#
#	break_dist =  ( distance / max(speed, 0.1) )
#
#	if not stop and slow:
#		speed = lerp(speed, (speed_acc / abs(angle_direction)) * 60, 0.1)
#
#	elif break_dist > 1:
#		speed = min(speed + speed_acc, min(speed_max, distance))
#	else:
#		speed = distance
#		stop = true
#
##	if true:
##		speed = min(speed_max, speed + speed_acc)
##	else:
##		speed = max(0, speed - speed_dec)
#
#
#func update_distance():
#	distance = global_position.distance_to(target)
#
#
#func update_direction():
#	direction = global_position.direction_to(target)
#
#
#func update_angle():
#	angle = direction.angle()
#	angle_direction = velocity.angle_to(direction)
#
#
#func update_rotation():
#	if abs(angle_direction) < sensivity_focus:
#		slow = false
#		sensivity_focus = 0.5
#	else:
#		sensivity_focus = 0.1
#		slow = true
#
#	global_rotation = lerp_angle(global_rotation, angle, speed_rotate)
#
#
#func update_target_pos():
#	target = target_pos + (target_pos.direction_to(global_position) * target_size)
#
#
#func update_gui():	
#	Gui.update_label(Gui.label.Speed, speed)
#	Gui.update_label(Gui.label.Position, global_position.round())
#	Gui.update_label(Gui.label.Location, target.round())
#	Gui.update_label(Gui.label.Distance, floor(distance))
#	Gui.update_label(Gui.label.SpeedAcc, speed_acc)
#	Gui.update_label(Gui.label.Angle, angle_direction)
#	Gui.update_label(Gui.label.Break, slow)
#	Gui.update_label(Gui.label.Velocity, velocity.round())
#
#
#func set_target(new_target_pos : Vector2, new_target_size : Vector2):
#	target_pos 	= new_target_pos
#	target_size = new_target_size
#	update_target_pos()
#
#	distance_f 	= global_position.distance_to(target_pos)
#
#	stop = false


































#export (float, 50, 50000, 50) var max_speed = 50
#
#
#var velocity : Vector2
#var direction: Vector2
#
#var angle 			: float
#var angle_direction  : float
#var distance_first 	: float
#var distance  		: float
#
#var speed : float = 0
#var speed_acc : float = 0
#
#var move_position : Vector2
#
#
#var forces_sides : Vector2 = Vector2.ONE * .01
#var forces_front : float = 3
#var forces_back : float = 3000
#
#var yoneldi_mi : bool = false
#
#
#func _physics_process(delta):
#	update_distance()
#
#	if distance <= 1:
#		return
#
#	update_direction()
#	update_rotation()
#
#
#	update_speed()
#	velocity = Vector2.RIGHT.rotated(global_rotation)
#
#	var g = move_and_slide(velocity * speed)
#
#	update_gui()
#
#
#func _input(event):
#	if event is InputEventScreenTouch and event.is_pressed():
##		move_position = get_global_mouse_position()
#
#		distance_first = global_position.distance_to(move_position)
#
#
#func update_rotation():
#	angle = direction.angle()
#
#	angle_direction = velocity.angle_to(direction)
#
#	if angle_direction > .1:
#		global_rotation += forces_sides.x
#	elif angle_direction < -.1:
#		global_rotation -= forces_sides.y
#	elif distance > 1:
#		yoneldi_mi = true
#
#	if abs(angle_direction) > .1:
#		yoneldi_mi = false
#
#
#func update_direction():
#	direction = (move_position - global_position).normalized()
#
#
#func update_distance():
#	distance = round(global_position.distance_to(move_position))
#
#var bisey
#func update_speed():
#	if yoneldi_mi:
#		bisey = forces_back * (max(.1, distance) / max_speed)
#		speed = lerp(speed, min(max_speed, bisey), .1)
#
##	if angle_direction < 0.5:
##		speed = lerp(speed, min(max_speed, distance), .1)
##	else:
##		update_rotation()
##		speed = lerp(speed, 0, angle_direction)
#
#
#func update_move_location(location : Vector2):
#	move_position = location
#
#
#func update_gui():
#	Gui.update_label(Gui.label.Speed, round(speed))
#	Gui.update_label(Gui.label.Location, move_position.round())
#	Gui.update_label(Gui.label.Angle, floor(angle))
#	Gui.update_label(Gui.label.Speed, round(speed))
#	Gui.update_label(Gui.label.Speed, round(speed))
