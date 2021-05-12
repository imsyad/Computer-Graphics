extends pixel

class_name circle


func midpoint_circle( 
	
	centre:Vector2,     # Centre point of circle
	radius              # Circle's radius
	
	):
	
	if radius <= 0:
		# Return nothing if radius less than 0
		return
	
	
	var x = radius
	var y = 0
	
	put_pixel( x + centre.x,  y + centre.y, Color.skyblue) # 0 Degree
	put_pixel(-y + centre.x, -x + centre.y, Color.violet)  # 90 Degree
	put_pixel(-x + centre.x, -y + centre.y, Color.violet)  # 180 Degree
	put_pixel( y + centre.x,  x + centre.y, Color.snow)    # 270 Degree
	
	
	var p = 5/4 - radius
	
	while ( x > y ):
		y += 1

		if ( p <= 0 ):
			p += 2 * y + 1

		else:
			x -= 1
			p += 2 * y - 2 * x + 1
		
		put_pixel(  x + centre.x,  y + centre.y, Color.skyblue  )
		put_pixel( -x + centre.x,  y + centre.y, Color.violet )
		put_pixel(  x + centre.x, -y + centre.y, Color.snow )
		put_pixel( -x + centre.x, -y + centre.y, Color.red )
		put_pixel(  y + centre.x,  x + centre.y, Color.red )
		put_pixel( -y + centre.x,  x + centre.y, Color.snow )
		put_pixel(  y + centre.x, -x + centre.y, Color.violet )
		put_pixel( -y + centre.x, -x + centre.y, Color.skyblue )
