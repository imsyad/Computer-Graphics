extends kamon


onready var timer = get_node("Timer")

var time = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	timer.start()


func _draw():
	kamon(Vector2(250,250), 150, Color.navyblue, time)
#	draw_midpoint_ellipse(150, 100, Vector2(350, 200), Color.navyblue, time)


func _on_Timer_timeout():
	time += 1
	update()
