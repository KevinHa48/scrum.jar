extends Spatial


onready var _retical = $Player/SpringArm/OVRFirstPerson/Retical
var fallingCube
var rng
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
	rng = RandomNumberGenerator.new()
	fallingCube = get_node("FallingBox")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not global.songplaying:
		deleteAllCubes()
		return
	_retical.visible = true
	var sum = 0
	for n in global.histogram:
		sum += n
	if sum < 6:
		return
	# for cube in cubes:
	# 	if cube.is_colliding():
	#		cubes.remove(cubes.find(cube))
	#		cube.queue_free()
	if len(cubes) <= maxCubes:
		var newCube = fallingCube.duplicate()
		newCube.visible = true
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
	for cube in cubes:
		if is_instance_valid(cube) && cube.translation.y <= 2:
			cubes.remove(cubes.find(cube))
			cube.queue_free()


func deleteAllCubes():
	for cube in cubes:
		if is_instance_valid(cube):
			cubes.remove(cubes.find(cube))
			cube.queue_free()


func randomSpawn():
	rng.randomize()
	return Vector3(rng.randf_range(-100, 100), 30, rng.randf_range(-100, 100))
