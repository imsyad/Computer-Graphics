extends Node2D


func put_pixel(x, y, color):
	# initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# draw the dot
	draw_primitive(points_dot, points_color, points_dot)


func round(num):
	return num + 0.5


func line_dda( xa,  ya,  xb,  yb, color ):
	var dx = xb - xa
	var dy = yb -ya
	var steps
	var k = 0
	
	var x_increment
	var y_increment
	var x = xa
	var y = ya
	
	if( abs(dx) > abs(dy) ): 
		steps = abs(dx)
	else:
		steps = abs (dy)
	
	x_increment = dx/steps
	y_increment = dy/steps
	
	put_pixel( round(x), round(y), color )
	
	while ( k  < steps ):
		x += x_increment
		y += y_increment
		put_pixel( round(x), round(y), color )
		k += 1


func line_bresenham( xa, ya, xb, yb, color ):
	var dx = abs ( xa - xb )
	var dy = abs ( ya - yb )
	var p = 2 * dy - dx
	var two_dy = 2 * dy
	var two_dy_dx = 2 * ( dy - dx )
	var x
	var y
	var x_end
	
	if ( xa > xb ):
		x = xb
		y = yb
		x_end = xa
	else:
		x = xa
		y = ya
		x_end = xb
		
	put_pixel( x, y, color)
		
	while( x < x_end ):
		x += 1
		if( p < 0 ):
			p += two_dy
		elif( p > 0 ) :
			y += 1
			p += two_dy_dx
		
		put_pixel( x, y, color )


func _ready():
	OS.window_size = Vector2 (800, 600)
	OS.window_resizable = false


func _draw():
	# Draw border with 10 margin
	# Top line
	line_bresenham( 10, 10, get_viewport().size.x - 10, 10, Color.honeydew )
	# Right line
	line_dda( get_viewport().size.x-10, 10, get_viewport().size.x-10, get_viewport().size.y-10, Color.honeydew )
	# Left line
	line_dda( 10, 10, 10, get_viewport().size.y - 10, Color.honeydew )
	# Bottom line
	line_bresenham( 10, get_viewport().size.y - 10, get_viewport().size.x - 10, get_viewport().size.y - 10, Color.honeydew )
	
	# Draw cartesian coordinate
	line_bresenham( 10, get_viewport().size.y/2, get_viewport().size.x - 10, get_viewport().size.y/2, Color.whitesmoke )
	line_dda( 400, 10, 400, get_viewport().size.y - 10, Color.whitesmoke )
	
	# Initialize variable
	var x_next
	var x_end
	var x
	
	# Draw graph for x^2 and x^3
	x = 385
	x_end = 415
	
	while(x < x_end):
		x_next = x + 0.1
		
		# Draw y = x^2 - 15 
		line_dda(x, ( 300 - pow( x - 400, 2 )) + 15, x_next, ( 300 - pow( x_next - 400, 2 )) + 15, Color.aqua )
		
		# Draw y = x^3
		line_dda(x, ( 300 - pow( x - 400, 3 )), x_next, ( 300 - pow( x_next - 400, 3 )), Color.yellow )
		
		x = x_next
	
	# Set x start and x_end -- 10 to 790
	x = 10
	x_end = 790
	
	while( x < x_end ):
		x_next = x + 0.1
		
		# Draw y = 50sin(x/5)
		line_dda(x, 50 * sin( (x - 10)/5 ) + 300, x_next, 50 * sin( (x_next - 10)/5 ) + 300, Color.crimson)
		
		# Draw y = 90cos(x/5)
		line_dda(x, 50 * cos( (x - 10)/5 ) + 300, x_next, 50 * cos( (x_next - 10)/5 ) + 300, Color.azure)
		x = x_next
	
