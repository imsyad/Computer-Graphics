extends kamon


onready var timer = get_node("timer")

var time = 0
var time_garis = 0
var time_kamon_1 = 0


func _ready():
	OS.window_resizable = false
	timer.start()


func animasi_garis(start_y, width):
	var start_x = -25
	var height = start_y
	
	var x1 = start_x
	var x2 = x1 + 250
	var x3 = x2 + 250
	var x4 = x3 + 250
	var x5 = x4 + 250
	
	if height + time_garis >= get_viewport().size.y:
		height = start_y - 750
	
	if time_garis >= 500 :
		time_garis = 0
	
	draw_line(Vector2(x1 + time_garis, height + time_garis), Vector2(x1 + time_garis + 50, height + time_garis + 50), Color.white, width)
	
	draw_line(Vector2(x2 + time_garis, height + time_garis), Vector2(x2 + time_garis + 50, height + time_garis + 50), Color.white, width)
	
	draw_line(Vector2(x3 + time_garis, height + time_garis), Vector2(x3 + time_garis + 50, height + time_garis +  50), Color.white, width)
	if x4 + time_garis > get_viewport().size.x + 50:
		x4 = -500 + x1
	draw_line(Vector2(x4 + time_garis, height + time_garis), Vector2(x4 + time_garis + 50, height + time_garis + 50), Color.white, width)
	if x5 + time_garis > get_viewport().size.x + 50:
		x5 = -250 + x1
	draw_line(Vector2(x5 + time_garis, height + time_garis), Vector2(x5 + time_garis + 50, height + time_garis + 50), Color.white, width)


func animasi_kamon(start_y, radius):
	var gap = (get_viewport().size.x - (6 * radius))/6
	
	var height = start_y
	var start_x = 0 
	
	var x1 = start_x + gap
	var x2 = 2 * gap
	var x3 = 5 * gap
	var x4 = 6 * gap
	
	if height + 25 * time_kamon_1 / 18 > get_viewport().size.y + radius:
		height = start_y - 750
	
	if time_kamon_1 >= 360 :
		time_kamon_1 = 0
		
	draw_kamon(Vector2(x1, height + 25 * time_kamon_1 / 18), radius, -time_kamon_1)
	draw_kamon(Vector2(x2, height + 25 * time_kamon_1 / 18), radius, -time_kamon_1)
	draw_kamon(Vector2(x3, height + 25 * time_kamon_1 / 18), radius, -time_kamon_1)
	draw_kamon(Vector2(x4, height + 25 * time_kamon_1 / 18), radius, -time_kamon_1)


func _draw():

	var radius = get_viewport().size.x/4
	
	var yd = -125
	while yd < get_viewport().size.y:
		animasi_garis(yd, radius/15)
		yd += 125
	
	yd = -125
	while yd < get_viewport().size.y:
		animasi_kamon(yd, radius/10)
		yd += 250
	
	
	
	draw_kamon(Vector2(get_viewport().size.x/2, get_viewport().size.y/2), radius, time)


func _on_Timer_timeout():
	time += 1
	time_garis +=  1
	time_kamon_1 += 1
	if time == 360:
		time = 0
	
	update()
