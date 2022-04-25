extends Spatial


onready var _retical = $Player/SpringArm/OVRFirstPerson/Retical
var fallingCube
var rng
var maxCubes = 400

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cubes = []

var enabledGameplay = global.play_origin != 'destress'

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
	deleteGroundCubes()
	if not global.songplaying:
		deleteAllCubes()
		return
	if enabledGameplay:
		_retical.visible = not global.paused
	var sum = 0
	for n in global.histogram:
		sum += n
	if sum < 4.5:
		return
	if len(cubes) <= maxCubes:
		var newCube = fallingCube.duplicate()
		newCube.visible = true
		newCube.translate(randomSpawn())
		newCube.linear_velocity = Vector3(0, - sum * 1.5, 0)
		newCube.set_gravity_scale(0.1)
		newCube.contact_monitor = true
		newCube.contacts_reported = 20
		# newCube.connect("body_entered", self, "on_newCube_body_entered")
		add_child(newCube)
		cubes.append(newCube)

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
	return Vector3(rng.randf_range(-200, 200), 100, rng.randf_range(-200, 200))
