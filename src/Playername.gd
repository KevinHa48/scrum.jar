extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var playername1: = $Playername
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Player name: " + global.playername
