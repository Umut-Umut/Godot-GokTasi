extends StaticBody2D


signal destroyed


onready var chunks = $Chunks

onready var polygon_explosive = $Explosive
onready var polygon_meteor = $Meteor
onready var polygon_collision = $CollisionPolygon2D
onready var polygon_meteor_background = $Meteor/Bacground
onready var polygon_area_collision = $ExplosiveDetector/CollisionPolygon2D
onready var chunk_scene = preload("res://Chunk/Chunk.tscn")


var new_chunk

var big_polygon : PoolVector2Array
var big_polygon_area : int = 0
var polygon_area : int = 0
var big_polygon_index : int = 0

var is_clockwise : bool = false
var is_created : bool = false
var is_destroyed : bool = false

# explode fonksiyonunda kopan parcalari bir rigid body ile dusurebilirim.


var clip_polygon : Array
var explosive_local_points : PoolVector2Array


func _ready():
	polygon_explosive.hide()
	
	connect("destroyed", self, "_meteor_destroyed")
	

func _physics_process(delta):
	rotate(delta)


func collision(collision_position : Vector2):
	explode(collision_position)
#	if body is Bullet:
#		body.disable()
#		explode(body.global_position)


func create_meteor(num_segments : int, radius : int):
	if is_created and not is_destroyed:
		return
	is_created = true
	is_destroyed = false
	
	
	# ChatGPT Sagolsun
	var points = []
	var angle_increment = 360.0 / num_segments

	# Dairenin noktalarını hesapla
	for i in range(num_segments):
		var angle = deg2rad(angle_increment * i)
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		points.append(Vector2(x, y))

	# Son noktayı ekleyin, çizginin tamamlanmasını sağlamak için
	points.append(points[0])

	# Çizgi segmentlerini ayarla
	polygon_meteor.polygon = points
	polygon_collision.polygon = points
#	polygon_area_collision.polygon = points
	polygon_meteor_background.polygon = points
	
	
	radius = 16
	points.clear()
	for i in range(num_segments):
		var angle = deg2rad(angle_increment * i)
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		points.append(Vector2(x, y))
	
	polygon_explosive.polygon = points
	explosive_local_points = polygon_explosive.polygon


func drop_chunk(chunk_points : PoolVector2Array):
	new_chunk = chunk_scene.instance()
	var new_poly = Polygon2D.new()
	new_poly.color = polygon_meteor.color
	new_poly.polygon = chunk_points
	new_chunk.add_child(new_poly)
	chunks.call_deferred("add_child", new_chunk)


func explode(collision_position : Vector2):
	polygon_explosive.global_position = collision_position
	
	
	for i in range(explosive_local_points.size()):
		explosive_local_points[i] = polygon_explosive.polygon[i] + polygon_explosive.position

	clip_polygon = Geometry.clip_polygons_2d(polygon_meteor.polygon, explosive_local_points)
	
	
	if clip_polygon.size() > 0:
		big_polygon_area = 0
		for i in range(clip_polygon.size()):
			polygon_area = PolygonMath.get_area(clip_polygon[i], Geometry.is_polygon_clockwise(clip_polygon[i]))
			if polygon_area > big_polygon_area:
				big_polygon_area = polygon_area
				big_polygon_index = i
		
		
		polygon_meteor.polygon = clip_polygon[big_polygon_index]
		polygon_collision.polygon = clip_polygon[big_polygon_index]
#		polygon_area_collision.set_deferred("polygon", clip_polygon[big_polygon_index])

		for i in range(0, clip_polygon.size()):
			if not i == big_polygon_index:
				drop_chunk(clip_polygon[i])
		
		if PolygonMath.get_area(clip_polygon[big_polygon_index], Geometry.is_polygon_clockwise(clip_polygon[big_polygon_index])) < 1000:			
			emit_signal("destroyed")
	else:
		emit_signal("destroyed")


func _meteor_destroyed():
	drop_chunk(polygon_meteor.polygon)
	polygon_meteor.polygon = PoolVector2Array()
	polygon_area_collision.set_deferred("polygon", polygon_meteor.polygon)
	
	is_destroyed = true


func _on_ExplosiveDetector_body_entered(body):
	if body is Bullet:
		return
		body.disable()
		explode(body.global_position)
		

	
#	var polygon_rotated_points = []
#	for p in polygon_meteor.polygon:
#		polygon_rotated_points.append(p.rotated(self.rotation) + polygon_meteor.global_position)
#
#	var explosive_local_points = []
#	for p in polygon_explosive.polygon:
#		explosive_local_points.append(p.rotated(self.rotation) + polygon_explosive.global_position)
#
#	clip_polygon = Geometry.clip_polygons_2d(polygon_rotated_points, explosive_local_points)
#
#	DebugPanel.update("clip_polygon_size", clip_polygon.size())
#
#	if clip_polygon.size() == 0:
#		DebugPanel.update("Oyun Bitti", 0)
#		polygon_meteor.polygon = PoolVector2Array()
#		polygon_collision.polygon = polygon_meteor.polygon
#
#	if clip_polygon.size() > 0:
#		if clip_polygon.size() == 2:
#			if clip_polygon[0].size() < clip_polygon[1].size():
#				var temp = clip_polygon[0]
#				clip_polygon[0] = clip_polygon[1]
#				clip_polygon[1] = temp
#			var new_polygon = Polygon2D.new()
#
#			for i in range(clip_polygon[1].size()):
#				clip_polygon[1][i] = (clip_polygon[1][i] - polygon_meteor.global_position).rotated(-self.rotation)
#
#			new_polygon.polygon = clip_polygon[1]
#			new_polygon.color = polygon_meteor.color
#			new_chunk = chunk_scene.instance()
#			new_polygon.position = polygon_meteor.position
#			new_chunk.add_child(new_polygon)
#			call_deferred("add_child", new_chunk)
#
#
#
#		for i in range(clip_polygon[0].size()):
#			clip_polygon[0][i] = (clip_polygon[0][i] - polygon_meteor.global_position).rotated(-self.rotation)
#
#		polygon_meteor.set_deferred("polygon", clip_polygon[0])
#		polygon_collision.set_deferred("polygon", clip_polygon[0])
#
#		polygon_explosive.hide()




