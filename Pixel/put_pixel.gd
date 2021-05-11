extends Node2D

class_name put_pixel


func put_pixel(
	# Represent of x point
	x, 
	# Represent of y point
	y, 
	# Argument for receiving the color of the point
	color
):
	# initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# draw the dot
	draw_primitive(points_dot, points_color, [])
