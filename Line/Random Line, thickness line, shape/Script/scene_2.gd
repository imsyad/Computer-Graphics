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


func _draw():
	# Parameter line_generator( x0, y0, x1, y1, weight, gap, color)
	line_generator(45, 105, 1000, 105, 5, 0, Color.yellow)
	line_generator(45, 155, 1000, 155, 15, 0, Color.yellow)
	line_generator(45, 205, 1000, 205, 5, 70, Color.aqua)
	line_generator(45, 255, 1000, 255, 15, 70, Color.aqua)
	line_generator(45, 305, 1000, 305, 10, 5, Color.red)
	line_generator(45, 355, 1000, 355, 10, 100, Color.red)
