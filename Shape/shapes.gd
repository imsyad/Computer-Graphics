extends lines

class_name shapes


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
		
		put_pixel( x + centre.x,  y + centre.y, Color.skyblue)
		put_pixel(-x + centre.x,  y + centre.y, Color.violet)
		put_pixel( x + centre.x, -y + centre.y, Color.snow)
		put_pixel(-x + centre.x, -y + centre.y, Color.red)
		put_pixel( y + centre.x,  x + centre.y, Color.red)
		put_pixel(-y + centre.x,  x + centre.y, Color.snow)
		put_pixel( y + centre.x, -x + centre.y, Color.violet)
		put_pixel(-y + centre.x, -x + centre.y, Color.skyblue) 


func midpoint_ellipse(

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


func draw_square(
	
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


func draw_rectangle( 
	
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


func draw_equilateral_triangle(
	
	centre:Vector2,
	pedestal,
	gap,
	weight,
	rotation_degree,
	color
	
	):
	# Initialize first dot
	var a = Vector2(centre.x, centre.y - ((pedestal * sqrt(3))/6))
	
	# Rotate a with 120 degree to get point b
	# Rotate inside initialization in order not to change the value of point a
	var b = Vector2(rotasi(centre, a, 120).x, rotasi(centre, a, 120).y)
	
	# Rotate a with 0 + degree
	# degree can be 0
	a = rotasi(centre, a, rotation_degree)
	
	# Rotate a with 0 + degree
	# degree can be 0
	b = rotasi(centre, b, rotation_degree)
	
	# Draw the line
	custom_line(a, b, weight, gap, color)
	
	
	for i in 2:
	# Repeat the following process twice
	
		# Rotate point a and b with 120
		a = rotasi (centre, a, 120)
		b = rotasi (centre, b, 120)
		
		# Draw the line
		custom_line(a, b, weight, gap, color)

# Function draw triangle for draw_rhombus function
# This function draw equilateral triangle without the pedestal
func equilateral_triangle_for_rhombus(
	
	centre:Vector2,
	pedestal,
	gap,
	weight,                     # Line weight
	rotation_degree,            # Rotation degree for the equilateral triangle
	rhombus_rotation_degree,    # Rotation degree for the rhombus formed 
	rhombus_centre,             # Centre of the rhombus formed
	color
	
	):
	
	var a    # Starting point of first line
	var b    # Ending point of first line
	var _a   # Starting point of second line
	var _b   # Ending point of second line
		
	# Initialize first dot
	a = Vector2(centre.x, centre.y - ((pedestal * sqrt(3))/6))
	
	# Rotate a with 120 degree to get point b
	# Rotate inside initialization in order not to change the value of point a
	b = Vector2(rotasi(centre, a, 120).x, rotasi(centre, a, 120).y)
	
	# Rotate a with 0 + degree
	# degree can be 0
	a = rotasi(centre, a, rotation_degree)
	
	# Rotate a with 0 + degree
	# degree can be 0
	b = rotasi(centre, b, rotation_degree)
	
	_a = rotasi (centre, a, 240)
	_b = rotasi (centre, b, 240)
	
	# Rotate the the first line if there is rotation on rhombus
	a = rotasi(rhombus_centre, a, rhombus_rotation_degree)
	b = rotasi(rhombus_centre, b, rhombus_rotation_degree)
	
	# Rotate the the second line if there is rotation on rhombus
	_a = rotasi(rhombus_centre, _a, rhombus_rotation_degree)
	_b = rotasi(rhombus_centre, _b, rhombus_rotation_degree)
	
	# Draw the line
	custom_line(a, b, weight, gap, color)
	custom_line(_a, _b, weight, gap, color)


func draw_rhombus(
	
	centre:Vector2,
	pedestal,
	gap,
	weight,
	rotation_degree,
	color
	
	):
	
	# Shift ordinate upward for upper equilateral triangle 
	var upper_centre = Vector2(centre.x, centre.y - ((pedestal * sqrt(3))/6)/2)
	
	# Shift ordinate downward for lower equilateral triangle
	var lower_centre = Vector2(centre.x, centre.y + ((pedestal * sqrt(3))/6)/2)
	
	# Draw upper and lower equilateral triangle 
	equilateral_triangle_for_rhombus(upper_centre, pedestal, gap, weight, 0, rotation_degree, centre, color)
	equilateral_triangle_for_rhombus(lower_centre, pedestal, gap, weight, 180, rotation_degree, centre, color)


#func draw_trapezoid ( xa:float, ya:float, top_length:float, bot_length:float, height:float, weight, gap, color ):
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
#func draw_parallelogram ( xa:float, ya:float, pedestal:float, height:float, shift:float, weight, gap, color ):
#
#	line_generator( xa ,ya, xa - shift, ya + height, weight, gap, color )
#	line_generator( xa - shift, ya + height, xa + pedestal - shift, ya + height, weight, gap, color )
#	line_generator( xa + pedestal - shift, ya + height, xa + pedestal, ya, weight, gap, color )
#	line_generator( xa + pedestal, ya, xa, ya, weight, gap, color )
#
#
