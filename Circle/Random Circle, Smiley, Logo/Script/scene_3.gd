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


func persegi_panjang( xa, ya, width, length, weight, gap, color ):
	
	# Illustration
	# A-------------B
	# |             |
	# D-------------C
	#
	# A is ( xa, ya )
	
	# Draw an AD line
	line_generator( xa, ya, xa, ya + width, weight, gap, color)
	
	# Draw a BC line
	line_generator( xa + length, ya, xa + length, ya + width, weight, gap, color)
	
	# Draw an AB line
	line_generator( xa, ya, xa + length, ya, weight, gap, color)
	
	# Draw a DC line
	line_generator( xa, ya + width, xa + length, ya + width, weight, gap, color)


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


func segitiga ( xa:float, ya:float, height:float, pedestal:float, weight, gap, color ):
	#
	# Illustration
	# A
	# | \
	# |   \ 
	# B----C
	#
	# A is ( xa, ya )
	
	# Draw an AB line
	line_generator( xa, ya, xa, ya + height, weight, gap, color )
	
	# Draw a BC line
	line_generator( xa, ya + height, xa + pedestal, ya + height, weight, gap, color )
	
	# Draw an AC line
	line_generator( xa, ya, xa + pedestal, ya + height, weight, gap, color )


func belah_ketupat ( xa:float, ya:float, d1:float, d2:float, weight, gap, color ):
	
	# Illustration 
	#       A                           |
	#     /   \                         |
	#    B     D         -----d2----   d1
	#     \   /                         |
	#       C                           |
	#
	# A is ( xa, ya )
	
	# Draw an AB line
	line_generator( xa, ya, xa - (d2/2), ya + (d1/2), weight, gap, color)
	
	# Draw a BC line
	line_generator( xa - (d2/2), ya + (d1/2), xa, ya + d1, weight, gap, color)
	
	# Draw a CD line
	line_generator(xa, ya + d1, xa + (d2/2), ya + (d1/2), weight, gap, color)
	
	# Draw a DA line
	line_generator(xa + (d2/2), ya + (d1/2), xa, ya, weight, gap, color)


func trapesium ( xa:float, ya:float, top_length:float, bot_length:float, height:float, weight, gap, color ):
	# Illustration
	# 
	# A----------D
	# |          \
	# B-----------C
	#
	# A is ( xa, ya )
	
	line_generator( xa, ya, xa, ya + height, weight, gap, color )
	line_generator( xa, ya + height, xa + bot_length, ya + height, weight, gap, color )
	line_generator( xa + bot_length, ya + height, xa + top_length, ya, weight, gap, color )
	line_generator( xa + top_length, ya, xa, ya, weight, gap, color )
	

func jajar_genjang ( xa:float, ya:float, pedestal:float, height:float, shift:float, weight, gap, color ):
	
	line_generator( xa ,ya, xa - shift, ya + height, weight, gap, color )
	line_generator( xa - shift, ya + height, xa + pedestal - shift, ya + height, weight, gap, color )
	line_generator( xa + pedestal - shift, ya + height, xa + pedestal, ya, weight, gap, color )
	line_generator( xa + pedestal, ya, xa, ya, weight, gap, color )


func _draw():
	persegi_panjang( 45, 100, 100, 200, 5, 0, Color.yellow )
	persegi ( 280, 100 , 100, 4, 20, Color.cyan)
	segitiga( 400.0, 100.0, 100.0, 50.0, 1, 0, Color.whitesmoke)
	belah_ketupat(165, 250, 200, 100, 1, 0, Color.blueviolet)
	trapesium( 250, 250, 50, 100, 100, 1, 10, Color.snow)
	jajar_genjang( 400, 250, 200, 130, 20, 1, 0, Color.coral)
