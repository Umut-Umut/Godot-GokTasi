extends StaticBody2D


onready var polygon_explosive = $Explosive
onready var polygon_meteor = $Meteor
onready var polygon_meteor_background = $Meteor/Bacground
onready var polygon_collision = $ExplosiveDetector/CollisionPolygon2D
onready var chunk_scene = preload("res://Chunk/Chunk.tscn")
var new_chunk


# explode fonksiyonunda kopan parcalari bir rigid body ile dusurebilirim.


var clip_polygon : Array
var explosive_local_points : PoolVector2Array


func _ready():
#	polygon_explosive.hide()
	
	# ChatGPT Sagolsun
	var num_segments = 12
	var radius = 192
	
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
	polygon_meteor_background.polygon = points
	
	
	explosive_local_points = polygon_explosive.polygon
	

func _process(delta):
	rotate(delta)


func drop_chunk(chunk_points : PoolVector2Array):
	new_chunk = chunk_scene.instance()
	var new_poly = Polygon2D.new()
	new_poly.color = polygon_meteor.color
	new_poly.polygon = chunk_points
	new_chunk.add_child(new_poly)
	call_deferred("add_child", new_chunk)	


func explode(collision_position : Vector2):
	polygon_explosive.global_position = collision_position
	
#
#	var local_explosive : PoolVector2Array
#	for p in polygon_explosive.polygon:
#		local_explosive.append(p + polygon_explosive.position)
#
	for i in range(explosive_local_points.size()):
		explosive_local_points[i] = polygon_explosive.polygon[i] + polygon_explosive.position

	clip_polygon = Geometry.clip_polygons_2d(polygon_meteor.polygon, explosive_local_points)
	
	
	if clip_polygon.size() > 0:
		DebugPanel.update("clip_polygon_size", clip_polygon.size())
		polygon_meteor.polygon = clip_polygon[0]
		polygon_collision.set_deferred("polygon", clip_polygon[0])

		for i in range(1, clip_polygon.size()):
			drop_chunk(clip_polygon[i])
		
#		for i in range(1, clip_polygon.size()):
#			new_chunk = chunk_scene.instance()
#			var new_poly = Polygon2D.new()
#			new_poly.color = polygon_meteor.color
#			new_poly.polygon = clip_polygon[i]
#			new_chunk.add_child(new_poly)
#			call_deferred("add_child", new_chunk)
		
	else:
		drop_chunk(polygon_meteor.polygon)
		
		polygon_meteor.polygon = PoolVector2Array()
		polygon_collision.set_deferred("polygon", polygon_meteor.polygon)
		DebugPanel.update("Oyun Bitti")
	
	
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


func _on_ExplosiveDetector_body_entered(body):
	if body is Bullet:
		explode(body.global_position)
		body.disable()
