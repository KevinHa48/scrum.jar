extends RigidBody

const speed = 10
var shoot = false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	pass # Replace with function body.

func _physics_process(delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("Falling Box"):
		body.queue_free()
		global.player_points += 1
	queue_free()
