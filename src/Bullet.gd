extends RigidBody

const SPEED = 10

var shoot = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)

func _physics_process(_delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z * SPEED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("Falling Box"):
		body.queue_free()
		global.player_points += 1
		print(global.player_points)
		# queue_free()
	# else:
		# queue_free()
