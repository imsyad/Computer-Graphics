extends Node2D

class_name put_pixel


func put_pixel(
	
	x,        # Represent of x point 
	y,        # Represent of y point
	color     # Argument for receiving the color of the point
	
	):
	
	# Initialize color
	var points_color = PoolColorArray()
	points_color.push_back(color);
	
	# Intialize dot
	var points_dot = PoolVector2Array()
	points_dot.push_back(Vector2(x,y))
	
	# Draw the dot
	draw_primitive(points_dot, points_color, [])

