extends put_pixel

class_name lines


func line_dda( 
	
	start  :Vector2,
	end    :Vector2, 
	color 
	
	):
	
	var dx:float      = end.x - start.x # Delta x 
	var dy:float      = end.y - start.y   # Delta y
	var k       = 0               # Counter for the number of repetitions remaining
	var x       = start.x
	var y       = start.y
	
	var steps                     # Line length
	var x_increment               # Increment for x
	var y_increment               # Increment for y
	
	
	if abs(dx) == 0 and abs(dy) == 0:
		return
		
	# Check if dx greater than dy
	if( abs(dx) > abs(dy) ): 
		# Assign dx to steps
		# dx is now line's length
		steps = abs(dx)
	
	else:
		# Assign dy to steps
		# dy is now line's length
		steps = abs (dy)
	
	# Set x and y increment
	x_increment = dx/steps
	y_increment = dy/steps
	
	# Put the starting point
	put_pixel(round(x), round(y), color)
	
	# Put point from starting point into ending point
	# Repeitions as many as the length of the line
	while ( k  < steps ):
		
		# Increment the x and y
		x += x_increment
		y += y_increment
		
		put_pixel( round(x), round(y), color )
		
		k += 1


func line_bresenham( 
	
	start :Vector2, 
	end   :Vector2, 
	color 
	
	):
	
	var dx        = end.x - start.x # Delta x 
	var dy        = end.y - end.y   # Delta y
	var p         = 2 * dy - dx     # Decision parameter
	var two_dy    = 2 * dy
	var two_dy_dx = 2 * (dy - dx)
	
	var x
	var y
	var x_end
	
	
	if ( start.x > end.x ):
		x     = end.x
		y     = end.y
		x_end = start.x
	
	else:
		x     = start.x
		y     = start.y
		x_end = end.x
	
	put_pixel( x, y, color)
	
	while( x < x_end ):
		
		x += 1
		
		if( p < 0 ):
			p += two_dy
		
		elif( p > 0 ) :
			y += 1
			p += two_dy_dx
		
		put_pixel( x, y, color )


# Custom line drawing function
# Include line's weight
# Can add gap inside the line
func custom_line( 
	
	start  :Vector2,             # Starting point
	end    :Vector2,             # Ending point
	weight :float,               # Line's weight
	gap    :int,                 # Gap inside the line
	color                        # Line's color
	
	):
	
	var dx    = end.x - start.x  # Delta x
	var dy    = end.y - start.y  # Delta y
	var k     = 0                # Counter for the number of repetitions remaining
	var steps                    # Line length
	
	
	# Return nothing if dx and dy are 0
	if dx == 0 and dy == 0:
		return
	
	var x_increment              # Increment for point's absis
	var y_increment              # Increment for point's ordinate
	var x = start.x              # Point's absis
	var y = start.y              # Point's ordinate
	
	var upper:Vector2            # For upper line's weight
	var lower:Vector2            # For lower line's weight
	
	weight = weight/2            # Split into two side
	
	
	# Condition for vertical line's weight value assignment
	if ( dx == 0 ):
		
		upper = Vector2( x - weight, y )
		lower = Vector2( x + weight, y )
	
	# Condition for horizontal line's weight value assignment
	elif ( dy == 0 ):
		
		upper = Vector2( x, y + weight )
		lower = Vector2( x, y - weight )
	
	# Condition for diagonal line's weight value assignment
	else:
		var m  :float   = dy/dx
		var m_p:float   = (-1) * ( 1/ m )
		var temp        = weight / sqrt( 1 + pow ( m_p, 2 ) )
		
		var x_lower     = temp + x
		var x_upper     = -temp + x
		
		var y_lower     = ( m_p * ( x_lower - x ) ) + y
		var y_upper     = ( m_p * ( x_upper - x ) ) + y
		
		upper           = Vector2( x_upper, y_upper )
		lower           = Vector2( x_lower, y_lower )
	
	
	# Check if dx greater than dy
	if( abs(dx) > abs(dy) ): 
		# Assign dx to steps
		# dx is now line's length
		steps = abs(dx)
	
	else:
		# Assign dy to steps
		# dy is now line's length
		steps = abs (dy)
	
	# Set x and y increment
	x_increment = dx/steps
	y_increment = dy/steps
	
	# Put starting point
	put_pixel( round(x), round(y), color )
	
	
	# Put point from starting point into ending point
	# Repeitions as many as the length of the line
	while ( k  < steps ):
		var x_add = x_increment
		var y_add = y_increment
		
		upper.x += x_add
		upper.y += y_add
		
		lower.x += x_add
		lower.y += y_add
		
		# Check wether gap is greater than 0
		if (gap > 0):
			
			# Draw a line only when k is in the odd multiple of the gap range 
			if ((k / gap) % 2 == 0):
				
				# Draw the line
				draw_weight( upper, lower, color)
		
		# No gap inside the lien
		else:
			
			# Draw the line
			draw_weight( upper, lower, color)
		
		k += 1


func draw_weight(
	
	start :Vector2,
	end   :Vector2,
	color
	
):
	var dx = end.x - start.x
	var dy = end.y - start.y
	
	var steps
	
	
	# Check if dx greater than dy
	if(abs(dx) > abs(dy)): 
		# Assign dx to steps
		# dx is now line's length
		steps = abs(dx)
	
	else:
		# Assign dy to steps
		# dy is now line's length
		steps = abs (dy)
	
	var x = start.x
	var y = start.y
	
	# Put starting point
	put_pixel( x, y, color )
	
	if ( steps > 0 ):
		
		var x_inc = dx/steps
		var y_inc = dy/steps
		
		# Loop as much as steps(line'e length)
		for i in steps:
			x += x_inc
			y += y_inc
			
			put_pixel( round(x), round(y), color )
