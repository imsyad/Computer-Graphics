extends Node2D


func _ready():
	pass


func _on_Button_pressed():
	var tree_back = get_tree()
	tree_back.change_scene("res://Scene/main.tscn")


func _on_go_to_scene_2_pressed():
	var tree_go_to_scene_2 = get_tree()
	tree_go_to_scene_2.change_scene("res://Scene/scene_2.tscn")


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


func get_color():
	# Function for select random color from an Array of Color
	var color_list = [Color.red, Color.yellow, Color.green, Color.aqua, Color.white, Color.seagreen]
	
	# Select random color from array
	var rand_color = color_list[randi() % color_list.size()]
	
	# Return color
	return rand_color
	
	
func _draw():
	# Create new RNG
	var rand = RandomNumberGenerator.new()
		
	# Randomize how much the line(s) and draw the line(s)
	for i in rand.randi_range(15, 25):
		var x0 = rand.randf_range(45.0, 1000.0)
		var y0 = rand.randf_range(45.0, 500.0)
		var x1 = rand.randf_range(45.0, 1000.0)
		var y1 = rand.randf_range(45.0, 500.0)
		
		line_dda(x0, y0, x1, y1, get_color())

