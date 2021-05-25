extends kamon

var time:int = 0
var gg:int = 0
onready var timer = get_node("Timer")

func _ready():
	OS.window_resizable = false
	timer.start()
	

func _on_Timer_timeout():
	time += 1
	update()



func _draw():
	var rad = 50
	var i = rad
	var j = -rad
	var starting_point = Vector2(i, j + time)
	
	var color = Color(0.83137, 0.8, 0.6352941176)
	kamon(starting_point, rad, color, time)
	
	if (starting_point.y - rad) > OS.get_window_size().y:
		time = 0
	




