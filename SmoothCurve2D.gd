extends Path2D

export var t_min = 0.0
export var t_max = 1.0
export var n_points = 20


func _ready():
	var step = (t_max - t_min)/n_points
	
	var points = []
	var derivatives = []
	
	for k in range(n_points):
		var t = k*step
		var p = _curve(t)
		var d = _dcurve(t)
		
		$RawLine.add_point(p)
		
		# Scale the control vectors with step to have the same time unit for the base curve and the Bézier curve
		var q_in = -d/3 * step
		var q_out = d/3 * step
		
		curve.add_point(p, q_in, q_out)
		
		
	$SmoothLine.points = curve.tessellate()


func _curve(t):
	return 200*Vector2(sin(5*PI*t), cos(7*PI*t))


func _dcurve(t):
	return 200*PI*Vector2(5*cos(5*PI*t), -7*sin(7*PI*t))