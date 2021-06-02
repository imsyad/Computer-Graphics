extends kamon


onready var timer = get_node("timer")

var time = 0
var time_garis = 0
var time_kamon_1 = 0


func _ready():
	OS.window_resizable = false
	timer.start()


func animasi_garis(start_x, start_y, radius):
	
	var height = start_y
	
	var x1 = start_x
	var x2 = x1 + 250
	var x3 = x2 + 250
	var x4 = x3 + 250
	var x5 = x4 + 250
	
	if height + time_garis >= get_viewport().size.y:
		height = start_y - 625
	
	
#	if x1 + time_garis > get_viewport().size.x + 50:
#		x1 -= 1250
	draw_line(Vector2(x1 + time_garis, height + time_garis), Vector2(x1 + time_garis + 50, height + time_garis + 50), Color.white, radius/10)
	print(time_garis)
#	if x2 + time_garis > get_viewport().size.x + 50:
#		x2 = -1000 + x1
	draw_line(Vector2(x2 + time_garis, height + time_garis), Vector2(x2 + time_garis + 50, height + time_garis + 50), Color.white, radius/10)
#	if x3 + time_garis > get_viewport().size.x + 50:
#		x3 = -750 + x1
	draw_line(Vector2(x3 + time_garis, height + time_garis), Vector2(x3 + time_garis + 50, height + time_garis +  50), Color.white, radius/10)
	if x4 + time_garis > get_viewport().size.x + 50:
		x4 = -500 + x1
	draw_line(Vector2(x4 + time_garis, height + time_garis), Vector2(x4 + time_garis + 50, height + time_garis + 50), Color.white, radius/10)
	if x5 + time_garis > get_viewport().size.x + 50:
		x5 = -250 + x1
	draw_line(Vector2(x5 + time_garis, height + time_garis), Vector2(x5 + time_garis + 50, height + time_garis + 50), Color.white, radius/10)
	
	if time_garis >= 500 :
		time_garis = 0

func _draw():

	var radius = get_viewport().size.x/4
	
	var yd = -125
	while yd < get_viewport().size.y:
		if (yd/50) % 2 == 1:
			animasi_garis(0, yd, radius)
		else:
			animasi_garis(0, yd, radius)
		yd += 125
	
	
	var j = 125
	var y_kamon = -radius/10 + time_kamon_1
	while j < get_viewport().size.x:
		draw_kamon(Vector2(j, y_kamon), radius/10, -time_kamon_1)
		j += 250
	
	if time_kamon_1 > get_viewport().size.y + radius/5:
		time_kamon_1 = 0
	
#	if time_garis > get_viewport().size.y + 50:
#		time_garis = 0
	
	if get_viewport().size.x/4 < get_viewport().size.y:
		radius = get_viewport().size.y/2
#	draw_kamon(Vector2(get_viewport().size.x/2, get_viewport().size.y/2), radius, time)


func _on_Timer_timeout():
	time += 1
	time_garis +=  1
	time_kamon_1 += 1
	if time == 360:
		time = 0
	
	update()
