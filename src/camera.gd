extends Spatial

export var sens := 0.1
export var ctrlsens := 0.2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var refPoint = get_parent().global_transform.origin


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event is InputEventMouseMotion and global.mouseactive:
		var movement = event.relative
		self.rotation.x -= deg2rad(movement.y * sens)
		self.rotation.y -= deg2rad(movement.x * sens)
	elif event is InputEventJoypadMotion and global.mouseactive:
		if Input.is_action_pressed("ui_look_left"):
			print("Looking left")
			self.rotation.y -= deg2rad(-1 * ctrlsens)
		if Input.is_action_pressed("ui_look_right"):
			print("Looking right")
			self.rotation.y -= deg2rad(1 * ctrlsens)
		if Input.is_action_pressed("ui_look_up"):
			print("Looking up")
			self.rotation.x -= deg2rad(-1 * ctrlsens)
		if Input.is_action_pressed("ui_look_down"):
			print("Looking down")
			self.rotation.x -= deg2rad(1 * ctrlsens)

func _toggleActive():
	global.mouseactive = !global.mouseactive
