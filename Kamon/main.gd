extends shapes

#func _ready():

func _draw():
	kamon(Vector2(50, 50), 50, Color.red, 0)
	kamon(Vector2(500, 200), 200, Color.red, 0)


func kamon_inner_arch(

	centre,
	arch_centre,
	rx,
	ry,
	degree_rotation,
	color
	
):
	var centre1 = rotasi(centre, arch_centre, 120)
	var centre2 = rotasi(centre, arch_centre, 240)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(arch_centre, "half", i, ry, 0)
		draw_midpoint_ellipse(arch_centre, "half", i, ry, 180)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(centre1, "half", i, ry, 120)
		draw_midpoint_ellipse(centre1, "half", i, ry, 300)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(centre2, "half", i, ry, 240)
		draw_midpoint_ellipse(centre2, "half", i, ry, 420)

func kamon_outer_arch(
	centre,
	arch_centre,
	rx,
	ry,
	degree_rotation,
	color
	
):
	var centre1 = rotasi(centre, arch_centre, 120)
	var centre2 = rotasi(centre, arch_centre, 240)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(arch_centre, "half", i, ry, 0)
		draw_midpoint_ellipse(arch_centre, "half", i, ry, 180)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(centre1, "half", i, ry, 120)
		draw_midpoint_ellipse(centre1, "half", i, ry, 300)
	
	for i in range (0, rx):
		draw_midpoint_ellipse(centre2, "half", i, ry, 240)
		draw_midpoint_ellipse(centre2, "half", i, ry, 420)

func kamon_inner_circle(
	
	centre: Vector2,
	radius,
	color
	
	):
	
	for i in range(0, radius):
		draw_midpoint_circle(centre, i, color)


func kamon_outer_circle(
	
	centre: Vector2,
	radius,
	color
	):
	
	for i in range(radius-(radius/10), radius):
		draw_midpoint_circle(centre, i, color)


func kamon(
	
	centre: Vector2,
	radius,
	color,
	degree_rotation
	
):
	var one_tenth_radius = radius/10
	var outer_small_radius = radius - radius/10
	var arch_radius = (outer_small_radius - one_tenth_radius)/2
	
	var centre_arch = Vector2(centre.x, (centre.y + one_tenth_radius) + ((outer_small_radius - one_tenth_radius)/2))
	
	kamon_outer_circle(centre, radius, color)
	kamon_inner_circle(centre, one_tenth_radius, color)
	kamon_inner_arch(centre, centre_arch, one_tenth_radius, arch_radius, degree_rotation, color)
