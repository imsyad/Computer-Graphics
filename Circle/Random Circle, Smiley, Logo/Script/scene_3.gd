extends Node2D


func _ready():
	pass


func _on_Button_pressed():
	var tree = get_tree()
	tree.change_scene("res://Scene/main.tscn")


func _on_go_to_scene_1_pressed():
	var tree_go_to_scene_1 = get_tree()
	tree_go_to_scene_1.change_scene("res://Scene/scene_1.tscn")


func _on_go_to_scene_2_pressed():
	var tree_go_to_scene_2 = get_tree()
	tree_go_to_scene_2.change_scene("res://Scene/scene_2.tscn")


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


func line_generator( xa,  ya,  xb,  yb, weight, gap, color ):

	var dx = xb - xa
	var dy = yb - ya
	var steps
	var k = 0
	
	var x_increment
	var y_increment
	var x = xa
	var y = ya
	
	# Var for weight 
	var x_weight
	var y_weight
	
	if( abs(dx) > abs(dy) ): 
		steps = abs(dx)
	else:
		steps = abs (dy)
	
	x_increment = dx/steps
	y_increment = dy/steps
	
	put_pixel( round(x), round(y), color )
	
	# Check whether there is a gap or not
	if (gap > 0):
		# Draw line with gap
		while ( k  < steps ):
			x += x_increment
			y += y_increment
			
			# Put pixel if only satisfy the condition
			if ( (k / gap) % 2 == 0 ):
				put_pixel( round(x), round(y), color)
				
				# Add some weight if weight > 0
				if ( weight > 0):
					x_weight = x
					y_weight = y
					for k_weight in weight:
						x_weight += y_increment
						y_weight += x_increment
						put_pixel( round(x_weight), round(y_weight), color)
				
			k += 1
		
	else:
		# Draw line without gap
		while ( k < steps ):
			x += x_increment
			y += y_increment
			put_pixel( round(x), round(y), color )
			
			# Add some weight if weight > 0
			if ( weight > 0):
				x_weight = x
				y_weight = y
				for k_weight in weight:
					x_weight += y_increment
					y_weight += x_increment
					put_pixel( round(x_weight), round(y_weight), color)
			k += 1


func persegi ( xa, ya, side, weight, gap, color ):
		
	# Illustration
	# A------B
	# |      |
	# D------C
	#
	# A is ( xa, ya )
	
	# Draw an AD line
	line_generator( xa, ya, xa, ya + side, weight, gap, color)
	
	# Draw a BC line
	line_generator( xa + side, ya, xa + side, ya + side, weight, gap, color)
	
	# Draw an AB line
	line_generator( xa, ya, xa + side, ya, weight, gap, color)
	
	# Draw a DC line
	line_generator( xa, ya + side, xa + side, ya + side, weight, gap, color)


func midpoint_circle( x_centre, y_centre, radius, color ):
	var x = radius
	var y = 0
	
	# 0 degree
	put_pixel( x + x_centre, y + y_centre, color )
	# 180 degree
	put_pixel( -x + x_centre, -y + y_centre, color )
	# 270 degree
	put_pixel( y + x_centre, x + y_centre, color )
	# 90 degree
	put_pixel( -y + x_centre, -x + y_centre, color )
	
	var p = 5/4 - radius
	
	while ( x > y ):
		y += 1

		if ( p <= 0 ):
			p += 2 * y + 1

		else:
			x -= 1
			p += 2 * y - 2 * x + 1
		
		put_pixel( x + x_centre, y + y_centre, color )
		put_pixel( -x + x_centre, y + y_centre, color )
		put_pixel( x + x_centre, -y + y_centre, color )
		put_pixel( -x + x_centre, -y + y_centre, color )
		
		put_pixel( y + x_centre, x + y_centre, color )
		put_pixel( -y + x_centre, x + y_centre, color )
		put_pixel( y + x_centre, -x + y_centre, color )
		put_pixel( -y + x_centre, -x + y_centre, color )


func draw_norton():
	var gold = Color(0.99215686274, 0.7333333333, 0.18823529411)
	# Circle
	var x = 500.0
	var y = 300.0
	for r in range (100, 130):
		midpoint_circle(x, y, r, gold)
	
	# Check Mark's addition
	x = 587
	y = 220
	for i in 4:
		
		persegi(x , y, 6, 5, 0, gold)
		
		y -= 15
		
		if ( i % 2 == 0):
			persegi(x + 5, y + 5, 6, 5, 0, Color.black)
		else:
			persegi(x - 5, y + 7, 6, 5, 0, Color.black)
			
		x += 15
	
	# Check Mark
	x = 490.0 
	y = 300.0
	for _y in range(310, 350):
		line_generator(x - 50, _y - 60, x, _y, 1, 0, Color.black)
		line_generator(x, _y, x + 120, _y - 120, 1, 0, Color.black)


func _draw():
	draw_norton()
