extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuInterface/AudioPlayer
	$TitleScreen.visible = false
	$SongMenu.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Selection_pressed():
	$MenuInterface.visible = false
	$SongMenu.visible = true


func _on_Replay_pressed():
	$MenuInterface.visible = false


func _on_MainMenu_pressed():
	$TitleScreen.visible = true
	$MenuInterFace.visible = false
