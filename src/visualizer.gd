# Based on Gonkee's audio visualiser: https://youtu.be/AwgSICbGxJM
extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(0, 0)

var visualizer = "circle"

var definition = 60
var min_freq = 20
var max_freq = 20000

# Size adjuster
var h = 800

var max_db = 0
var min_db = -40

var accel = 20
var histogram = []

func _ready():
	max_db += get_parent().volume_db
	min_db += get_parent().volume_db
	
	for _i in range(definition):
		histogram.append(0)

func _process(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.05, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
	
	update()

func _draw():
	# Linear Visualiser
	if visualizer == "linear":
		var w = h * 2
		var draw_pos = Vector2(0, 0)
		var w_interval = w / definition
		draw_line(Vector2(0, -h), Vector2(w, -h), Color.crimson, 2.0, true)
		
		for i in range(definition):
			draw_line(draw_pos, draw_pos + Vector2(0, -histogram[i] * h), Color.crimson, 4.0, true)
			draw_pos.x += w_interval
	# Radial Visualiser
	elif visualizer == "circle":
		var angle = PI
		var angle_interval = 2 * PI / definition
		var r = h / 2
		var L = r
		for i in range(definition):
			var normal = Vector2(0, -1).rotated(angle)
			var start_pos = normal * r
			var end_pos = normal * (r + histogram[i] * L)
			draw_line(start_pos, end_pos, Color.dodgerblue, 4.0, true)
			angle += angle_interval
