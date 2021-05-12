extends Node2D

class_name pixel


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


func rotasi(coor1:Vector2,coor2:Vector2,degree):
	var rotX
	var rotY
	
	var vcos = cos(deg2rad(degree))
	var vsin = sin(deg2rad(degree))
	var x1=coor1.x
	var y1=coor1.y
	var x2=coor2.x
	var y2=coor2.y
	
	rotX = (vcos * (x2 - x1)) + (-vsin * (y2 - y1)) + x1
	rotY = (vsin * (x2 - x1)) + (vcos * (y2 - y1)) + y1
	
	return Vector2(rotX,rotY)
