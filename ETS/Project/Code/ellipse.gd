# Program     : Class elips.
# Deskripsi   : Class yang memiliki function untuk menggambar sebuah elips.
# Penulis     : Irsyad Muhammad.
# Versi       : 2.


extends utilitas

class_name ellipse


func draw_midpoint_ellipse(rx:float, ry:float, centre:Vector2, color,degree:int):
	var dx:float
	var dy:float
	var d1:float
	var d2:float
	var x:float
	var y:float
	var points = PoolVector2Array()
	var points1 = PoolVector2Array()
	var points2 = PoolVector2Array()
	var points3 = PoolVector2Array()
	var points4 = PoolVector2Array()
	
	x = 0
	y = ry
	
	# initial decision parameter of region 1
	# ry^2 - rx^2ry + 1/4 rx^2
	d1 = ( ry * ry ) - ( rx * rx * ry ) + (0.25 * rx * rx)
	dx = 2 * ry * ry * x
	dy = 2 * rx * rx * y
	
	# for region 1
	while ( dx < dy ):
	
		points1.append(rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree))
		points2.append(rotasi(centre, Vector2(x + centre.x, y + centre.y), degree))
		points3.append(rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree))
		points4.append(rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree))
		
		if ( d1 < 0 ):
			x += 1
			dx += 2 * ry * ry
			d1 += dx + (ry * ry)
		else:
			x += 1
			y -= 1
			
			dx += 2 * ry * ry
			dy -= 2 * rx * rx
			d1 += dx - dy + (ry * ry)
	
	# decision parameter of region 2
	d2 = ((ry * ry ) * ((x + 0.5) * (x + 0.5))) + ((rx * rx) * ((y - 1) * (y - 1))) - (rx * rx * ry * ry)
	
	# plotting for region 2
	while ( y >= 0 ):
	
		points1.append(rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree))
		points2.append(rotasi(centre, Vector2(x + centre.x, y + centre.y), degree))
		points3.append(rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree))
		points4.append(rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree))
		
		
		if ( d2 > 0 ):
			y -= 1
			dy -= 2 * rx * rx
			d2 += (ry * ry) - dy
		
		else:
			y -= 1
			x += 1
			dx += 2 * ry * ry
			dy -= 2 * rx * rx
			d2 += dx - dy + (rx * rx)

	points.append_array(points1)
	
	var n = points4.size() - 1
	while  n > 0:
		points.append(points4[n])
		n -= 1
	
	points.append_array(points3)
	
	n = points2.size() - 1
	while  n > 0:
		points.append(points2[n])
		n -= 1
	
	draw_polygon(points, [color])
