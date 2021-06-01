extends ellipse

class_name kamon


func kamon_arch(

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
		
#	for i in range (rx/4, rx):
	draw_midpoint_ellipse(rx - rx/4, ry, centre0, color, 0 + degree_rotation)
	
	draw_midpoint_ellipse(rx - rx/4, ry, centre1, color, 120 + degree_rotation)
	
	draw_midpoint_ellipse(rx - rx/4, ry, centre2, color, 60 + degree_rotation)



func kamon_inner_circle(
	
	centre: Vector2,
	radius,
	color
	
	):
	
	draw_circle(centre, radius, color)


func kamon_outer_circle(
	
	centre: Vector2,
	radius,
	color
	):
	
#	for i in range(radius-(radius/10), radius):
	draw_arc(centre, radius, 0, 360, 1000, color, radius/10)


func kamon(
	
	centre: Vector2,
	radius,
	color,
	degree_rotation
	
):
	var one_tenth_radius   = radius/10
	var outer_small_radius = radius - radius/10
	var arch_radius        = (outer_small_radius - one_tenth_radius)/2
	
	var centre_arch = Vector2(centre.x, (centre.y + one_tenth_radius) + ((outer_small_radius - one_tenth_radius)/2))
	
	kamon_outer_circle(centre, radius, color)
	kamon_inner_circle(centre, one_tenth_radius, color)
	kamon_arch(centre, centre_arch, one_tenth_radius, arch_radius, degree_rotation, color)
