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


func _on_more_pressed():
	var tree_random = get_tree()
	tree_random.change_scene("res://Scene/scene_1.tscn")

func put_pixel(x, y, color):
	# initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# draw the dot
	draw_primitive(points_dot, points_color, points_dot)


func midpoint_circle( x_centre, y_centre, radius ):
	var x = radius
	var y = 0
	
	var p = 5/4 - radius
	
	while ( x >= y ):
		y += 1

		if ( p <= 0 ):
			p += 2 * y + 1

		else:
			x -= 1
			p += 2 * y - 2 * x + 1
		
		put_pixel( x + x_centre, y + y_centre, Color.skyblue  )
		put_pixel( -x + x_centre, y + y_centre, Color.violet )
		put_pixel( x + x_centre, -y + y_centre, Color.snow )
		put_pixel( -x + x_centre, -y + y_centre, Color.red )
		put_pixel( y + x_centre, x + y_centre, Color.red )
		put_pixel( -y + x_centre, x + y_centre, Color.snow )
		put_pixel( y + x_centre, -x + y_centre, Color.violet )
		put_pixel( -y + x_centre, -x + y_centre, Color.skyblue )


func get_color():
	# Function for select random color from an Array of Color
	var color_list = [Color.red, Color.yellow, Color.skyblue, Color.aqua, Color.white, Color.seagreen, Color.violet, Color.snow]
	
	# Select random color from array
	var rand_color = color_list[randi() % color_list.size()]
	
	# Return color
	return rand_color
	
	
func _draw():
	var rng = RandomNumberGenerator.new()

	rng.randomize()
	for i in rng.randi_range(5, 10):
		rng.randomize()
		var x = rng.randi_range(90, 900)
		var y = rng.randi_range(90, 450)
		var r = rng.randi_range(50, 150)
		midpoint_circle( x, y, r )
