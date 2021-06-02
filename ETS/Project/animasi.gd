extends kamon


onready var timer = get_node("Timer")

var time = 0

func _ready():
	timer.start()


func _draw():
	
	var radius = get_viewport().size.x/4
	if get_viewport().size.x/4 < get_viewport().size.y:
		radius = get_viewport().size.y/2
	draw_kamon(Vector2(get_viewport().size.x/2, get_viewport().size.y/2), radius, time)


func _on_Timer_timeout():
	time += 1
	
	if time == 360:
		time = 0
	
	update()
