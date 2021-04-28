extends Node2D


func _ready():
	pass


func _on_Button_pressed():
	var tree_back = get_tree()
	tree_back.change_scene("res://Scene/main.tscn")


func _on_go_to_scene_1_pressed():
	var tree_go_to_scene_1 = get_tree()
	tree_go_to_scene_1.change_scene("res://Scene/scene_1.tscn")


func _on_go_to_scene_3_pressed():
	var tree_go_to_scene_3 = get_tree()
	tree_go_to_scene_3.change_scene("res://Scene/scene_3.tscn")


func _on_more_pressed():
	var tree_more = get_tree()
	tree_more.change_scene("res://Scene/scene_2.tscn")


func put_pixel(x, y, color):
	# initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# draw the dot
	draw_primitive(points_dot, points_color, points_dot)


func midpoint_circle( x_centre, y_centre, radius, octane_start, octane_end ):
	var x = radius
	var y = 0	
		
	if ( octane_start < 3 && octane_end > 6 ):
		# 0 degree
		put_pixel( x + x_centre, y + y_centre, Color.skyblue)
		# 90 degree
		put_pixel( -y + x_centre, -x + y_centre, Color.violet )
		# 180 degree
		put_pixel( -x + x_centre, -y + y_centre, Color.violet )
	else:
		# 270 degree
		put_pixel( y + x_centre, x + y_centre, Color.snow )
	
	var p = 5/4 - radius
	
	while ( x > y ):
		y += 1
		
		if ( p <= 0 ):
			p += 2 * y + 1
		
		else:
			x -= 1
			p += 2 * y - 2 * x + 1
			
		for circle_range in range (octane_start, octane_end + 1):
			
			if( circle_range == 1 && circle_range <= octane_end ):
				# 1
				put_pixel( y + x_centre, -x + y_centre, Color.violet )
			if ( circle_range == 2 && circle_range <= octane_end ):
				# 2
				put_pixel( x + x_centre, -y + y_centre, Color.snow )
			if( circle_range == 3 && circle_range <= octane_end ):
				# 3
				put_pixel( x + x_centre, y + y_centre, Color.skyblue  )
				
			if( circle_range == 4 && circle_range <= octane_end ):
				# 4
				put_pixel( y + x_centre, x + y_centre, Color.red )
				
			if( circle_range == 5 && circle_range <= octane_end ):
				# 5
				put_pixel( -y + x_centre, x + y_centre, Color.snow )
				
			if( circle_range == 6 && circle_range <= octane_end ):
				# 6
				put_pixel( -x + x_centre, y + y_centre, Color.violet )
				
			if( circle_range == 7 && circle_range <= octane_end ):
				# 7
				put_pixel( -x + x_centre, -y + y_centre, Color.red )
			
			if( circle_range == 8 && circle_range <= octane_end ):
				# 8
				put_pixel( -y + x_centre, -x + y_centre, Color.skyblue )
			
			circle_range += 1


func round(num):
	return num + 0.5


func line_generator( xa,  ya,  xb,  yb, weight, gap:int, color ):

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


func smiley( x, y, r, color):

	# Base
	midpoint_circle( x, y, r, 1, 8)
	# Mouth circle ( Arc )
	midpoint_circle( x, y , 2*r/3, 4, 5 )
	# Mouth line ( x :Circle bowstring, y :apothem )
	line_generator( x - (PI * 2 * r / 3)/4, y + sqrt( pow(2*r/3,2) - pow((PI * 2 * r / 3)/4,2) ), x + (PI * 2 * r / 3)/4 , y + sqrt( pow(2*r/3,2) - pow((PI * 2 * r / 3)/4,2) ), 1, (PI * 2 * r / 3)/40, color )
	# Eyes
	midpoint_circle( x - r/3, y - r/3, r/6, 1, 8 )
	midpoint_circle( x + r/3, y - r/3, r/6, 1, 8 )
	# Nose
	line_generator( x - r/16, y-r/30, x - r/16, y + r/5, r/10, 7 * r / 150, color )


func _draw():
	var rng = RandomNumberGenerator.new()

	rng.randomize()
	for i in rng.randi_range(5, 10):
		rng.randomize()
		var x = rng.randi_range(90, 900)
		var y = rng.randi_range(90, 450)
		var r = rng.randi_range(50, 150)
		smiley( x, y, r, Color.yellow)
