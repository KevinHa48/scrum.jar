extends Spatial

export var sens := 0.1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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

func _toggleActive():
	global.mouseactive = !global.mouseactive
