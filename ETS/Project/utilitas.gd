# Program     : Class utilitas.
# Deskripsi   : Class yang memiliki function untuk merotasi sebuah titik.
# Penulis     : -
# Versi       : -


extends Node2D

class_name utilitas


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
