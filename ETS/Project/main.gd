extends kamon

var time = 0
var color = Color(0.83137, 0.8, 0.6352941176)
var rad = 25
var starting_point:Vector2
var ending_point:Vector2
onready var timer = get_node("Timer")

func _ready():
	OS.window_resizable = false
	timer.start()


func _on_Timer_timeout():
	time += 1

	starting_point = Vector2(0 + time, 0 + time)
	ending_point = Vector2(starting_point.x - 350 , starting_point.y - 350)
	update()


func _draw():
#	kamon(Vector2(250, 250), 150, color, 0)
	draw_polygon([Vector2(15,20), Vector2(25, 50), Vector2(25, 100)], [color])
