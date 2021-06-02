# Program     : Class kamon.
# Deskripsi   : Class yang memiliki function untuk menggambar sebuah kamon.
# Penulis     : Irsyad Muhammad.
# Versi       : 1.


extends ellipse

class_name kamon


func dasar_kamon(centre:Vector2, radius, warna):
	draw_circle(centre, radius, warna)


func kelopak_kamon(pusat_kamon, pusat_kelopak, rx, ry, warna, derajat_rotasi):
	var _pusat_kelopak_1 = rotasi(pusat_kamon, pusat_kelopak, 0 + derajat_rotasi)
	var _pusat_kelopak_2 = rotasi(pusat_kamon, pusat_kelopak, 120 + derajat_rotasi)
	var _pusat_kelopak_3 = rotasi(pusat_kamon, pusat_kelopak, 240 + derajat_rotasi)
	
	draw_midpoint_ellipse(rx, ry, _pusat_kelopak_1, warna, 0 + derajat_rotasi)
	draw_midpoint_ellipse(rx, ry, _pusat_kelopak_3, warna, 60 + derajat_rotasi)
	draw_midpoint_ellipse(rx, ry, _pusat_kelopak_2, warna, 120 + derajat_rotasi)


func lingkaran_kamon(centre: Vector2,radius,color):
	draw_circle(centre, radius + radius/7, Color.thistle)
	draw_circle(centre, radius, color)


func outline_kamon(centre: Vector2,radius,color):
	draw_arc(centre, radius - radius/10, 0, 360, 1000, color, radius/10)


func draw_kamon(centre: Vector2,radius, derajat_rotasi):
	var pusat_kelopak          = Vector2(centre.x, centre.y + (radius - radius/10)/2)
	var radius_lingkaran_dalam = radius/10
	var radius_lingkaran_luar  = radius - radius/10
	var radius_kelopak         = (radius - radius/5)/2
	var warna = Color.white
	var warna_outline = Color.white
	
	dasar_kamon        (centre, radius_lingkaran_luar, Color(0,0,0,1))
	kelopak_kamon      (centre, pusat_kelopak, radius/5, radius_kelopak, warna, derajat_rotasi)
	outline_kamon      (centre, radius, warna_outline)
	lingkaran_kamon    (centre, radius_lingkaran_dalam, warna)
