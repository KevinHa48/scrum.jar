extends WorldEnvironment

var d = 0.0; var dup = true;
var r = 0.5; var rup = true;
var g = 0.5; var gup = true;
var b = 0.5; var bup = true;

# Script should be added in the inspector mode and referenced.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calcColors():
	if(r >= 1.0): rup = false;
	elif(r <= 0.5): rup = true;
	if(g >= 1.0): gup = false;
	elif(g <= 0.5): gup = true;
	if(b >= 1.0): bup = false;
	elif(b <= 0.5): bup = true;
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if(rup): r = r + rng.randf_range(0.0000, 0.005)
	else: r = r - rng.randf_range(0.0000, 0.005)
	if(gup): g = g + rng.randf_range(0.0000, 0.005)
	else: g = g - rng.randf_range(0.0000, 0.005)
	if(bup): b = b + rng.randf_range(0.0000, 0.005)
	else: b = b - rng.randf_range(0.0000, 0.005)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	calcColors()
	self.environment.background_color = Color(r,g,b,1)
		
