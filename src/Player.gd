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
onready var _scoreLbl = $SpringArm/OVRFirstPerson/VBoxContainer/ScoreLbl
onready var _newScoreLbl = $SpringArm/OVRFirstPerson/VBoxContainer/NewScoreLbl
onready var _accLbl = $SpringArm/OVRFirstPerson/VBoxContainer/AccLbl
onready var _shotsLbl = $SpringArm/OVRFirstPerson/VBoxContainer/ShotsLbl
onready var _hitsLbl = $SpringArm/OVRFirstPerson/VBoxContainer/HitsLbl
onready var _safetyModeLbl = $SpringArm/OVRFirstPerson/SafetyModeLbl
onready var _retical = $SpringArm/OVRFirstPerson/Retical
onready var _timeLbl = $SpringArm/OVRFirstPerson/TimeLbl
onready var _font = _scoreLbl.get_font("font")
onready var _audioStream = self.get_node("../MusicUploadScreen/AudioStreamPlayer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	_show_safety_label()
	timer.connect("timeout",self,"_revert_text") 
	add_child(timer)
	get_tree().get_root().connect("size_changed", self, "on_size_changed")
	_indicator.force_raycast_update()
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
	if _audioStream.stream:
		_timeLbl.set_text(_format_remaining_time())
	_spring_arm.translation = translation
	if Input.is_action_just_pressed("fire"):
		if _indicator.is_colliding():
			if hit_scan:
				var block = _indicator.get_collider()
				if block.is_in_group("Falling Box"):
					block.queue_free()
					var newPoints = block.get_translation().y as int
					global.player_points += newPoints
					#print(global.player_points)
					
					global.shots_fired += 1
					_shotsLbl.set_text("Shots: " + str(global.shots_fired))
					
					_scored_text(newPoints)
					_scoreLbl.set_text("Score: " + str(global.player_points))
					
					global.shots_hit += 1
					_hitsLbl.set_text("Hits: " + str(global.shots_hit))
					
					timer.start(0.5)
			else:
				var b = bullet.instance()
				add_child(b)
				b.look_at(_indicator.get_collision_point(), Vector3.UP)
				b.shoot = true
		else:
			global.shots_fired += 1
			_shotsLbl.set_text("Shots: " + str(global.shots_fired))

func _format_remaining_time():
	var curTime = _audioStream.get_playback_position() as int
	var totalTime = _audioStream.stream.get_length() as int
	var timeLeftSecs = totalTime - curTime
	var timeLeftMins = timeLeftSecs / 60 as int
	timeLeftSecs = timeLeftSecs % 60 as int
	
	var retStr = ""
	
	if timeLeftMins < 10:
		retStr += "0"
	retStr += str(timeLeftMins) + ":"
	if timeLeftSecs < 10:
		retStr += "0"
	retStr += str(timeLeftSecs)
	
	return retStr
	
func _scored_text(pts):
	_scoreLbl.set("custom_colors/font_color", Color(255,255,0,1))
	_font.size = 42
	_newScoreLbl.visible = true
	_newScoreLbl.set_text("+" + str(pts))
				
func _revert_text():
	_scoreLbl.set("custom_colors/font_color", Color(1,1,1,1))
	_font.size = 40
	_newScoreLbl.visible = false

func _show_safety_label():
	_safetyModeLbl.visible = global.safetyMode
