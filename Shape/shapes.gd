extends lines

class_name shapes


func midpoint_circle ( 
	
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
		
		put_pixel( x + centre.x,  y + centre.y, Color.skyblue)
		put_pixel(-x + centre.x,  y + centre.y, Color.violet)
		put_pixel( x + centre.x, -y + centre.y, Color.snow)
		put_pixel(-x + centre.x, -y + centre.y, Color.red)
		put_pixel( y + centre.x,  x + centre.y, Color.red)
		put_pixel(-y + centre.x,  x + centre.y, Color.snow)
		put_pixel( y + centre.x, -x + centre.y, Color.violet)
		put_pixel(-y + centre.x, -x + centre.y, Color.skyblue) 


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
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).x, 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).y, 
			Color.crimson )
		
		put_pixel( 
			rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).x, 
			rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).y, 
			Color.cornflower )
		
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).x, 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).y, 
			Color.yellow )
		
		put_pixel( 
			rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).x, 
			rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).y, 
			Color.springgreen )
		
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
			rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).x, 
			rotasi(centre, Vector2(x + centre.x, y + centre.y), degree).y, 
			Color.crimson )
			
		put_pixel( 
			rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).x, 
			rotasi(centre, Vector2(-x + centre.x, y + centre.y), degree).y, 
			Color.cornflower )
			
		put_pixel( 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).x, 
			rotasi(centre, Vector2(x + centre.x, -y + centre.y), degree).y, 
			Color.yellow )
						
		put_pixel( 
			rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).x, 
			rotasi(centre, Vector2(-x + centre.x, -y + centre.y), degree).y, 
			Color.springgreen )
						
		
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


func persegi(
	
	centre :Vector2,
	side,
	gap,
	weight,
	rotation_degree,
	color
	
	):
	
	
	if side <= 0:
		return
	
	var start = Vector2(centre.x - side/2, centre.y - side/2)
	var end   = Vector2(centre.x + side/2, centre.y + side/2)
	
	custom_line(
		rotasi(centre, Vector2(start.x, start.y), rotation_degree), 
		rotasi(centre, Vector2(start.x, end.y), rotation_degree), 
		weight, gap, color)
	
	custom_line(
		rotasi(centre, Vector2(start.x, end.y), rotation_degree), 
		rotasi(centre, Vector2(end.x, end.y), rotation_degree),
		weight, gap, color)
	
	custom_line(
		rotasi(centre,Vector2(end.x, end.y), rotation_degree),
		rotasi(centre, Vector2(end.x, start.y), rotation_degree),
		weight, gap, color)
	
	custom_line(
		rotasi(centre, Vector2(end.x, start.y), rotation_degree),
		rotasi(centre, Vector2(start.x, start.y), rotation_degree),
		weight, gap, color)



func persegi_panjang( 
	
	start :Vector2, 
	end   :Vector2, 
	gap,
	weight,
	rotation_degree,
	color 
	
	):
	
	if start.x == end.x or start.y == end.y :
		return
	
	
	var x_centre = abs((start.x - end.x)/2)
	var y_centre = abs((start.y - end.y)/2)
	var centre
	
	
	# Initialise centre point of the rectangle
	if start.x < end.x :
		if start.y < end.y:
			centre = Vector2(start.x + x_centre, start.y + y_centre)
		else:
			centre = Vector2(start.x + x_centre, start.y - y_centre)
	else:
		if start.y < end.y:
			centre = Vector2(start.x - x_centre, start.y + y_centre)
		else:
			centre = Vector2(start.x - x_centre, start.y - y_centre)
	
	custom_line(
		rotasi(centre, Vector2(start.x, start.y), rotation_degree), 
		rotasi(centre, Vector2(start.x, end.y), rotation_degree), 
		weight, gap, color)
	
	custom_line(
		rotasi(centre, Vector2(start.x, end.y), rotation_degree), 
		rotasi(centre, Vector2(end.x, end.y), rotation_degree),
		weight, gap, color)
	
	custom_line(
		rotasi(centre,Vector2(end.x, end.y), rotation_degree),
		rotasi(centre, Vector2(end.x, start.y), rotation_degree),
		weight, gap, color)
	
	custom_line(
		rotasi(centre, Vector2(end.x, start.y), rotation_degree),
		rotasi(centre, Vector2(start.x, start.y), rotation_degree),
		weight, gap, color)
	


#func segitiga ( xa:float, ya:float, height:float, pedestal:float, weight, gap, color ):
#	#
#	# Illustration
#	# A
#	# | \
#	# |   \ 
#	# B----C
#	#
#	# A is ( xa, ya )
#
#	# Draw an AB line
#	line_generator( xa, ya, xa, ya + height, weight, gap, color )
#
#	# Draw a BC line
#	line_generator( xa, ya + height, xa + pedestal, ya + height, weight, gap, color )
#
#	# Draw an AC line
#	line_generator( xa, ya, xa + pedestal, ya + height, weight, gap, color )
#
#
#func belah_ketupat ( xa:float, ya:float, d1:float, d2:float, weight, gap, color ):
#
#	# Illustration 
#	#       A                           |
#	#     /   \                         |
#	#    B     D         -----d2----   d1
#	#     \   /                         |
#	#       C                           |
#	#
#	# A is ( xa, ya )
#
#	# Draw an AB line
#	line_generator( xa, ya, xa - (d2/2), ya + (d1/2), weight, gap, color)
#
#	# Draw a BC line
#	line_generator( xa - (d2/2), ya + (d1/2), xa, ya + d1, weight, gap, color)
#
#	# Draw a CD line
#	line_generator(xa, ya + d1, xa + (d2/2), ya + (d1/2), weight, gap, color)
#
#	# Draw a DA line
#	line_generator(xa + (d2/2), ya + (d1/2), xa, ya, weight, gap, color)
#
#
#func trapesium ( xa:float, ya:float, top_length:float, bot_length:float, height:float, weight, gap, color ):
#	# Illustration
#	# 
#	# A----------D
#	# |          \
#	# B-----------C
#	#
#	# A is ( xa, ya )
#
#	line_generator( xa, ya, xa, ya + height, weight, gap, color )
#	line_generator( xa, ya + height, xa + bot_length, ya + height, weight, gap, color )
#	line_generator( xa + bot_length, ya + height, xa + top_length, ya, weight, gap, color )
#	line_generator( xa + top_length, ya, xa, ya, weight, gap, color )
#
#
#func jajar_genjang ( xa:float, ya:float, pedestal:float, height:float, shift:float, weight, gap, color ):
#
#	line_generator( xa ,ya, xa - shift, ya + height, weight, gap, color )
#	line_generator( xa - shift, ya + height, xa + pedestal - shift, ya + height, weight, gap, color )
#	line_generator( xa + pedestal - shift, ya + height, xa + pedestal, ya, weight, gap, color )
#	line_generator( xa + pedestal, ya, xa, ya, weight, gap, color )
#
#
