extends Polygon2D


func _ready():
	# ChatGPT Sagolsun
	var num_segments = 16
	var radius = 64 * 3
	
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
	polygon = points
	

func _process(delta):
	rotate(delta)
