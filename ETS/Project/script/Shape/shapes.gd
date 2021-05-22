extends lines

class_name shapes


func draw_midpoint_circle( 
	
	centre:Vector2,     # Centre point of circle
	radius,             # Circle's radius
	color               # Circle's color
	
	):
	
	if radius <= 0:
		# Return nothing if radius less than 0
		return
	
	
	var x = radius
	var y = 0
	
	put_pixel( x + centre.x,  y + centre.y, color)         # 0 Degree
	put_pixel(-y + centre.x, -x + centre.y, color)         # 90 Degree
	put_pixel(-x + centre.x, -y + centre.y, color)         # 180 Degree
	put_pixel( y + centre.x,  x + centre.y, color)         # 270 Degree
	
	
	var p = 5/4 - radius
	
	while ( x > y ):
		y += 1

		if ( p <= 0 ):
			p += 2 * y + 1

		else:
			x -= 1
			p += 2 * y - 2 * x + 1
		
		put_pixel( x + centre.x,  y + centre.y, color)
		put_pixel(-x + centre.x,  y + centre.y, color)
		put_pixel( x + centre.x, -y + centre.y, color)
		put_pixel(-x + centre.x, -y + centre.y, color)
		put_pixel( y + centre.x,  x + centre.y, color)
		put_pixel(-y + centre.x,  x + centre.y, color)
		put_pixel( y + centre.x, -x + centre.y, color)
		put_pixel(-y + centre.x, -x + centre.y, color) 


func draw_midpoint_ellipse(
	
	centre:Vector2,
	rx,
	ry,
	rotation_degree,
	color
	
	):
	
	var dx:float
	var dy:float
	var d1:float
	var d2:float
	var x:float
	var y:float
	
	x = 0
	y = ry
	
	# initial decision parameter of region 1
	# ry^2 - rx^2ry + 1/4 rx^2
	d1 = ( ry * ry ) - ( rx * rx * ry ) + (0.25 * rx * rx)
	dx = 2 * ry * ry * x
	dy = 2 * rx * rx * y
	
	# for region 1
	while ( dx < dy ):
		
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), rotation_degree).x, 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), rotation_degree).y, 
			color )
		
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), rotation_degree).x, 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), rotation_degree).y, 
			color)
		
		
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
	
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), rotation_degree).x, 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), rotation_degree).y, 
			color )
		
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), rotation_degree).x, 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), rotation_degree).y, 
			color )
		
		
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

