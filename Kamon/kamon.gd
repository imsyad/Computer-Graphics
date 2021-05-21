extends shapes

class_name kamon

func kamon_inner_arch(
	
	centre,
	arch_centre,
	rx,
	ry,
	degree_rotation,
	color
	
	):
	var centre0 = rotasi(centre, arch_centre, 0 + degree_rotation)
	var centre1 = rotasi(centre, arch_centre, 120 + degree_rotation)
	var centre2 = rotasi(centre, arch_centre, 240 + degree_rotation)
	
	for i in range (rx/4, rx):
		draw_midpoint_ellipse(centre0, "half", i, ry, 0 + degree_rotation, color)
		draw_midpoint_ellipse(centre0, "half", i, ry, 180 + degree_rotation, color)
	
	for i in range (rx/4, rx):
		draw_midpoint_ellipse(centre1, "half", i, ry, 120 + degree_rotation, color)
		draw_midpoint_ellipse(centre1, "half", i, ry, 300 + degree_rotation, color)
	
	for i in range (rx/4, rx):
		draw_midpoint_ellipse(centre2, "half", i, ry, 240 + degree_rotation, color)
		draw_midpoint_ellipse(centre2, "half", i, ry, 420 + degree_rotation, color)

func kamon_outer_arch(
	centre,
	arch_centre,
	rx,
	ry,
	degree_rotation,
	color
	
	):
	var centre0 = rotasi(centre, arch_centre, 0 + degree_rotation)
	var centre1 = rotasi(centre, arch_centre, 120+ degree_rotation)
	var centre2 = rotasi(centre, arch_centre, 240+ degree_rotation)
	
	for i in range (rx + rx/2, 5 * rx/2):
		draw_midpoint_ellipse(centre0, "half", i, ry, 0 + degree_rotation, color)
		draw_midpoint_ellipse(centre0, "half", i, ry, 180 + degree_rotation, color)
	
	for i in range (rx + rx/2, 5 * rx/2):
		draw_midpoint_ellipse(centre1, "half", i, ry, 120 + degree_rotation, color)
		draw_midpoint_ellipse(centre1, "half", i, ry, 300 + degree_rotation, color)
	
	for i in range (rx + rx/2, 5 * rx/2):
		draw_midpoint_ellipse(centre2, "half", i, ry, 240 + degree_rotation, color)
		draw_midpoint_ellipse(centre2, "half", i, ry, 420 + degree_rotation, color)

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
	kamon_outer_arch(centre, centre_arch, one_tenth_radius, arch_radius, degree_rotation, color)
