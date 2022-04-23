extends KinematicBody

export var speed := 7.0
export var jump_strength := 20.0
export var gravity := 50.0

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

const hit_scan = true

onready var _spring_arm: SpringArm = $SpringArm
onready var bullet = preload("res://src/Bullet.tscn")
onready var _indicator = $SpringArm/OVRFirstPerson/Indicator
onready var _scoreLbl = $SpringArm/ScoreLabel
onready var _retical = $SpringArm/OVRFirstPerson/Retical
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "on_size_changed")
	_indicator.force_raycast_update()
	_retical.visible = true
	on_size_changed()
	#_indicator.set_translation(Vector3(0, center.y / 2, _indicator.translation.z))
	
func on_size_changed():
	var center = OS.get_window_size()
	_retical.set_position(Vector2(center.x / 2 - 16, center.y / 2 - 16))
	#_indicator.set_translation(Vector3(0, center.y / 2, _indicator.translation.z))
	
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
	_spring_arm.translation = translation
	if Input.is_action_just_pressed("fire"):
		if _indicator.is_colliding():
			if hit_scan:
				var block = _indicator.get_collider()
				if block.is_in_group("Falling Box"):
					block.queue_free()
					global.player_points += 100
					print(global.player_points)
					_scoreLbl.set_text("Score: " + str(global.player_points))
			else:
				var b = bullet.instance()
				add_child(b)
				b.look_at(_indicator.get_collision_point(), Vector3.UP)
				b.shoot = true
