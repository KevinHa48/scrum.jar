extends KinematicBody

export var speed := 7.0
export var jump_strength := 20.0
export var gravity := 50.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm
onready var bullet = preload("res://src/Bullet.tscn")
onready var _indicator = $SpringArm/OVRFirstPerson/Indicator
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var b = bullet.duplicate()
		if b:
			add_child(b)
			b.velocity = -b.transform.basis.z * b.muzzle_velocity
	_spring_arm.translation = translation
	
	if Input.is_action_just_pressed("fire"):
		print("hit !1")
		if _indicator.is_colliding():
			var block = _indicator.get_collider()
			print(block.get_class())
			#print(block.group)
			if block.is_in_group("Falling Box"):
				block.queue_free()
				print("hit !3")
	
	
