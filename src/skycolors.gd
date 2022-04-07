extends WorldEnvironment

var d = 0.0; var dup = true;
var r = 0.5; var rup = true;
var g = 0.5; var gup = true;
var b = 0.5; var bup = true;
var size_of_third = global.definition / 3

# Script should be added in the inspector mode and referenced.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calcColors():
	var color_change_rate = 0.005
	
	if(r >= 1.0): rup = false;
	elif(r <= 0.5): rup = true;
	if(g >= 1.0): gup = false;
	elif(g <= 0.5): gup = true;
	if(b >= 1.0): bup = false;
	elif(b <= 0.5): bup = true;
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if global.play_origin != 'normal':
		color_change_rate = 0.0025
	
	if(rup): r = r + rng.randf_range(0.0000, color_change_rate)
	else: r = r - rng.randf_range(0.0000, color_change_rate)
	if(gup): g = g + rng.randf_range(0.0000, color_change_rate)
	else: g = g - rng.randf_range(0.0000, color_change_rate)
	if(bup): b = b + rng.randf_range(0.0000, color_change_rate)
	else: b = b - rng.randf_range(0.0000, color_change_rate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calcColors()
	var bottom_avg = 0
	for i in range(size_of_third):
		bottom_avg += global.histogram[i]
	bottom_avg /= size_of_third
	
	var middle_avg = 0
	for i in range(size_of_third, size_of_third * 2):
		middle_avg += global.histogram[i]
	middle_avg /= size_of_third
	
	var high_avg = 0
	for i in range(size_of_third * 2, size_of_third * 3):
		high_avg += global.histogram[i]
	high_avg /= size_of_third
	
	self.environment.background_color = Color(bottom_avg, middle_avg, high_avg, 1)
		
