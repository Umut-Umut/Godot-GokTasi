class_name PolygonMath


static func get_area(points : PoolVector2Array, is_clockwise : bool) -> int:
	var points_size : int = points.size()
	var ii : int
	var area : int = 0
	for i in range(points_size):
		ii = (i + 1) % points_size
		
		if is_clockwise:
			area += (points[ii].x * points[i].y) - (points[i].x * points[ii].y)
		else:
			area += (points[i].x * points[ii].y) - (points[ii].x * points[i].y)
	
	return area / 2
