extends kamon

var time = 0


func _ready():
	OS.window_resizable = false

func _process(delta):
	time += 2 * delta
	update()


func _draw():
	var i = 50 
	var j = 50
	
	while i < OS.window_size.x:
		while j < OS.window_size.y:
			kamon(Vector2(i, j), j/10, Color(0.83137, 0.8, 0.6352941176), time)
			kamon(Vector2(i, j + 50), j/10, Color(0.83137, 0.8, 0.6352941176), time)
			i += OS.window_size.x/10
			j += OS.window_size.y/10
		

