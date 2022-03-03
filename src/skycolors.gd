extends Gradient
var r = 0.0; var rup = true;
var g = 0.0; var gup = true;
var b = 0.0; var bup = true;

# Script should be added in the inspector mode and referenced.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calcColors(delta):
	if(r >= 1.0): rup = false;
	elif(r <= 0.0): rup = true;
	if(g >= 1.0): gup = false;
	elif(g <= 0.0): gup = true;
	if(b >= 1.0): bup = false;
	elif(b <= 0.0): bup = true;
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if(rup): r = r + delta + rng.randf_range(0, 0.05)
	else: r = r - delta - rng.randf_range(0, 0.05)
	if(gup): g = g + delta + rng.randf_range(0, 0.05)
	else: g = g - delta - rng.randf_range(0, 0.05)
	if(bup): b = b + delta + rng.randf_range(0, 0.05)
	else: b = b - delta - rng.randf_range(0, 0.05)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	calcColors(delta)
	# Incorrect point change here..
	var gradient1 = self
	gradient1.set_color(1, Color(r,g,b,1))
	#$MeshInstance.material_override = material	
	print(self.get_colors())
	#self.set_gradient(gradient1)
	self.set_color(1, Color(r,g,b,1))
	print(self.get_colors())
	pass
