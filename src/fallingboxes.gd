extends Spatial


var fallingCube
var maxCubes = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cubes = []

func on_newCube_body_entered(body):
	# If cube has collided with ground, delete it from the scene and the list.
	cubes.remove(cubes.find(body))
	body.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	fallingCube = get_node("FallingBox")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# for cube in cubes:
	# 	if cube.is_colliding():
	#		cubes.remove(cubes.find(cube))
	#		cube.queue_free()
	if len(cubes) <= maxCubes:
		var newCube = fallingCube.duplicate()
		if newCube:
			newCube.translate(randomSpawn())
			newCube.set_gravity_scale(0.1)
			newCube.contact_monitor = true
			newCube.contacts_reported = 20
			# newCube.connect("body_entered", self, "on_newCube_body_entered")
			add_child(newCube)
			cubes.append(newCube)
	#else:
		#var cube_to_delete = cubes[0]
		#print(cube_to_delete.translation.y)
		#cubes.remove(0)
		#cube_to_delete.queue_free()
	
	deleteGroundCubes()

func deleteGroundCubes():
	var toBeRemovedCubes = []
	for i in len(cubes):
		if(cubes[i].translation.y <= 2):
			toBeRemovedCubes.append(cubes[i])
	
	for i in toBeRemovedCubes:
		var cube_to_delete = cubes[0]
		cubes.remove(0)
		cube_to_delete.queue_free()
			

func randomSpawn():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	return Vector3(rng.randf_range(-100, 100), 30, rng.randf_range(-100, 100))
