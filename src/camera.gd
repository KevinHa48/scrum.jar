extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var sens = 0.1
var active = true
func _input(event):
	if event is InputEventMouseMotion and active:
		var movement = event.relative
		self.rotation.x += -deg2rad(movement.y * sens)
		self.rotation.y += -deg2rad(movement.x * sens)

func _toggleActive():
	active = !active
