# Program     : Class animasi.
# Deskripsi   : Class yang memiliki function untuk menggambar sebuah adegan/scene animasi.
# Penulis     : Irsyad Muhammad.
# Versi       : 1.


extends kamon


onready var timer = get_node("timer")

var wait = -30

var time       = 0      # Variabel waktu yang berguna untuk animasi dari kamon besar
var time_garis = 0      # Variabel waktu yang berguna untuk animasi dari garis
var time_kamon = 0      # Variabel waktu yang berguna untuk animasi dari kamon (kecil)
var time_increment = 1  # Variabel untuk menambahkan ketiga variabel time di atas


var rotasi_time = 0
var rotasi_kamon = 0
var rotasi_increment = 1


func _ready():
	# Menonaktifkan fungsi pengaturan ulang ukuran window
	OS.window_resizable = false
	
	# Memulai perhitungan mundur
	timer.start()


# Function untuk menggambar kelompok garis yang dianimasikan
# Function ini akan menggambar 5 garis dengan nilai x yang berbeda tetapi 
# memiliki nilai x yang sama. Yang kemudian akan dilakukan transformasi.
#
# start_y adalah parameter untuk menerima nilai y dari garis
# width adalah parameter untuk menrima nilai dari lebar garis
func animasi_garis(start_y, width):
	var start_x = -25        # Nilai x dari garis pertama
	var height  = start_y    # Nilai y untuk semua garis
	
	var x1 = start_x
	var x2 = x1 + 250
	var x3 = x2 + 250
	var x4 = x3 + 250
	var x5 = x4 + 250
	
	# Memeriksa apakah nilai y garis sudah melewati ukuran y dari viewport
	if time_increment >=0 :
		if height + time_garis >= get_viewport().size.y:
			# Kembalikan nilai y agar lebih kecil dari ukuran y viewport
			height = start_y - 750
	
	elif time_increment < 0 :
		if height + time_garis <= -50:
			# Kembalikan nilai y agar lebih kecil dari ukuran y viewport
			height = start_y + 750
	
	# Memeriksa apakah timer untuk garis sudah melebihi/sama dengan 500
	if time_garis >= 500 or time_garis <= -500:
		# Mengatur kembali nilai timer garis menjadi 0
		time_garis = 0
	
	# Menggambar kelima garis
	
	
	# Memeriksa apakah nilai x dari garis di bawah ini sudah lebih besar dari
	# ukuran x viewport
	if x1 + time_garis < -50:
		# Mengatur kembali nilai x agar lebih kecil dari ukuran x viewport
		x1 = get_viewport().size.x + 195
	
	draw_line(Vector2(x1 + time_garis, height + time_garis), 
			  Vector2(x1 + time_garis + 50, height + time_garis + 50), 
			  Color.white, 
			  width)
	
	# Memeriksa apakah nilai x dari garis di bawah ini sudah lebih besar dari
	# ukuran x viewport
	if x2 + time_garis < -50:
		# Mengatur kembali nilai x agar lebih kecil dari ukuran x viewport
		x2 = get_viewport().size.x + 445
	
	draw_line(Vector2(x2 + time_garis, height + time_garis), 
			  Vector2(x2 + time_garis + 50, height + time_garis + 50), 
			  Color.white, 
			  width)
	
	draw_line(Vector2(x3 + time_garis, height + time_garis), 
			  Vector2(x3 + time_garis + 50, height + time_garis +  50), 
			  Color.white, 
			  width)
	
	# Memeriksa apakah nilai x dari garis di bawah ini sudah lebih besar dari
	# ukuran x viewport
	if x4 + time_garis > get_viewport().size.x + 50:
		# Mengatur kembali nilai x agar lebih kecil dari ukuran x viewport
		x4 = -500 + x1
	
	draw_line(Vector2(x4 + time_garis, height + time_garis), 
			  Vector2(x4 + time_garis + 50, height + time_garis + 50), 
			  Color.white, 
			  width)
	
	# Memeriksa apakah nilai x dari garis di bawah ini sudah lebih besar dari
	# ukuran x viewport
	if x5 + time_garis > get_viewport().size.x + 50:
		# Mengatur kembali nilai x agar lebih kecil dari ukuran x viewport
		x5 = -250 + x1
	
	draw_line(Vector2(x5 + time_garis, height + time_garis), 
			  Vector2(x5 + time_garis + 50, height + time_garis + 50), 
			  Color.white, 
			  width)


# Function untuk menggambar kelompok kamon yang dianimasikan
# Function ini akan menggambar 4 buah kamon nilai x yang berbeda tetapi 
# memiliki nilai x yang sama. Yang kemudian akan dilakukan transformasi.
#
# start_y adalah parameter untuk menerima nilai posisi y dari kamon
# radius adalah parameter untuk menerima nilai radius dari kamon
func animasi_kamon(start_y, radius):
	# Var untuk gap antar kamon
	var gap = (get_viewport().size.x - (6 * radius))/6
	
	var height  = start_y    # Nilai y awal dari semua kamon
	var start_x = 0          # Nilai x dari kamon pertama
	
	# Mengatur nilai x untuk masing masing kamon
	var x1 = start_x + gap
	var x2 = 2 * gap
	var x3 = 5 * gap
	var x4 = 6 * gap
	
	if time_increment >= 0:
		# Memeriksa apakah nilai y kamon sudah melebihi ukuran y dari viewport
		if height + 25 * time_kamon / 18 > get_viewport().size.y + radius:
			# Mengatur kembali nilai y agar lebih kecil dari ukuran y viewport
			height = start_y - 750
	
	else:
		if height + 25 * time_kamon / 18 < -radius:
			# Mengatur kembali nilai y agar lebih kecil dari ukuran y viewport
			height = start_y + 750
	
	# Memeriksa apakan nilai timer kamon sudah melebihi/sama dengan 360
	if time_kamon >= 360 or time_kamon <= -360:
		# Mengatur kembali timer kamon menjadi 0
		time_kamon = 0
	
	# Menggambar keempat kamon
	# nilai 25 * time_kamon / 18 digunakan untuk menyesuaikan rasio dari 500/360
	draw_kamon(Vector2(x1, height + 25 * time_kamon / 18), radius, rotasi_kamon)
	draw_kamon(Vector2(x2, height + 25 * time_kamon / 18), radius, rotasi_kamon)
	draw_kamon(Vector2(x3, height + 25 * time_kamon / 18), radius, rotasi_kamon)
	draw_kamon(Vector2(x4, height + 25 * time_kamon / 18), radius, rotasi_kamon)


# Function untuk menggambar kamon besar
# radius adalah parameter untuk menerima radius dari kamon
func animasi_kamon_besar(radius):
	# Memeriksa apakah nilai mod dari 20 adalah 1
	# Flow control ini akan menghasilkan "efek" seperti kamon yang sedang berdentum 
	if time % 20 == 1:
		draw_kamon(
			Vector2(get_viewport().size.x/2, get_viewport().size.y/2), 
			radius * 21 / 20, 
			rotasi_time)
	else:
		draw_kamon(
			Vector2(get_viewport().size.x/2, get_viewport().size.y/2), 
			radius, 
			rotasi_time)
	
	# Memeriksa apakah waktu sudah lebih besar/sama dengan 360
	if time >= 360:
		time = 0


# Function untuk menggambar item yang akan digambar 
func _draw():
	var radius = get_viewport().size.x/4
	var i = -125
	
	if wait > 0:
		# Menggambar animasi garis mulai dari y = -125 hingga i mendekati ukuran viewport y
		while i < get_viewport().size.y:
			animasi_garis(i, radius/15)
			i += 125
	
	if wait > 15:
		# Mengatur ulang nilai i untuk dipakai menggambar animasi kamon
		i = -125
		
		# Menggambar animasi kamon mulai dari y = -125 hingga i mendekati ukuran viewport y
		while i < get_viewport().size.y:
			animasi_kamon(i, radius/10)
			i += 250
	
	if wait > 29:
		# Menggambar animasi kamon besar
		animasi_kamon_besar(radius)


# Function penerima signal ketika node Timer countdown nya mencapai nilai 0
func _on_Timer_timeout():
	# Menunggu kemunculan objek
	if wait <= 30 :
		wait += 1
	else:
		wait += 0
		
	# Mengubah kecepatan
	if Input.is_key_pressed(KEY_RIGHT):
		if time_increment < 0:
			time_increment -= 1
		else:
			time_increment += 1
		
	elif Input.is_key_pressed(KEY_LEFT):
		if time_increment >= 0:
			time_increment -= 1
		else:
			time_increment += 1
	
	# Merubah arah rotasi
	if Input.is_key_pressed(KEY_1):
		rotasi_increment = 1
	elif Input.is_key_pressed(KEY_2):
		rotasi_increment = -1
	
	# Merubah arah muncul
	if Input.is_key_pressed(KEY_4):
		time_increment = -1
	elif Input.is_key_pressed(KEY_3):
		time_increment = 1
	
	# Changelog: Mengubah increment yang awalnya hanya bernilai 1, menjadi sebuah variabel
	time += time_increment
	time_garis +=  time_increment
	time_kamon += time_increment
	rotasi_kamon += rotasi_increment
	rotasi_time  += rotasi_increment
	
	# Melakukan update untuk _draw
	update()
