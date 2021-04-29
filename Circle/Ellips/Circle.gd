extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func put_pixel(x, y, color):
	# initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# draw the dot
	draw_primitive(points_dot, points_color, points_dot)


func midpoint_circle (x_centre, y_centre, r, color):
	var x = r
	var y = 0
	
	# Print the initial point
	# 0 degree
	put_pixel(x + x_centre, y + y_centre, color)
	
	if( r > 0 ):
		# 180 degree
		put_pixel( -x + x_centre, -y + y_centre, color )
		# 270 degree
		put_pixel( y + x_centre, x + y_centre, color )
		# 90 degree
		put_pixel( -y + x_centre, -x + y_centre, color )
	
	# Initialising the value of p
	var p = 5/4 - r
	
	while (x > y):
		y += 1
		
		# mid-point is inside or on the perimeter
		if ( p <= 0 ):
			p += 2 * y + 1
			
		# mid-point is outside the perimeter
		else:
			x -= 1
			p += 2 * y - 2 * x + 1
		
		if ( x < y ):
			break
		
		# printing the generated point and its reflection
		# in order octants after translation 
		put_pixel( x + x_centre, y + y_centre, color )
		put_pixel( -x + x_centre, y + y_centre, color )
		put_pixel( x + x_centre, -y + y_centre, color )
		put_pixel( -x + x_centre, -y + y_centre, color )
		
		# if the generated point is on the line x = y
		# then perimeter points have already been printed
		if( x != y ):
			put_pixel( y + x_centre, x + y_centre, color )
			put_pixel( -y + x_centre, x + y_centre, color )
			put_pixel( y + x_centre, -x + y_centre, color )
			put_pixel( -y + x_centre, -x + y_centre, color )


func midpoint_ellipse ( rx, ry, x_centre, y_centre, color ):
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
		put_pixel( x + x_centre, y + y_centre, color )
		put_pixel( -x + x_centre, y + y_centre, color )
		put_pixel( x + x_centre, -y + y_centre, color )
		put_pixel( -x + x_centre, -y + y_centre, color )
		
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
		put_pixel( x + x_centre, y + y_centre, color )
		put_pixel( -x + x_centre, y + y_centre, color )
		put_pixel( x + x_centre, -y + y_centre, color )
		put_pixel( -x + x_centre, -y + y_centre, color )
		
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


func _draw():
	midpoint_ellipse(250, 150, 300, 250, Color.yellow)
	midpoint_circle(800, 250, 150, Color.white)
