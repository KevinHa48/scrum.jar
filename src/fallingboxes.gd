extends Spatial


var fallingCube
var maxCubes = 100
var numCubes = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	fallingCube = get_node("FallingBox")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(numCubes <= maxCubes):
		var newCube = fallingCube.duplicate() as RigidBody
		
		if(newCube != null):
			numCubes += 1
			newCube.translate(randomSpawn())
			get_parent().add_child(newCube)
			
			
func randomSpawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	return Vector3(rng.randf_range(-100, 100), rng.randf_range(-100, 100), rng.randf_range(-100, 100))
