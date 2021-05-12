extends pixel

class_name ellipse


func midpoint_ellipse (
	rx,
	ry, 
	centre:Vector2, 
	degree
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
		put_pixel( rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).x, 
						rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).y, Color.crimson )
						
		put_pixel( rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).x, 
						rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).y, Color.cornflower )
						
		put_pixel( rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).x, 
						rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).y, Color.yellow )
						
		put_pixel( rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).x, 
						rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).y, Color.springgreen )
		
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
		put_pixel( rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).x, 
					rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).y, Color.crimson )
						
		put_pixel( rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).x, 
					rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).y, Color.cornflower )
						
		put_pixel( rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).x, 
					rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).y, Color.yellow )
						
		put_pixel( rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).x, 
					rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).y, Color.springgreen )
						
		
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
