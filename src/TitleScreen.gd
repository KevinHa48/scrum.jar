extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var _audio_player = $NinePatchRect/AudioPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MusicUploadBtn_pressed():
	$NinePatchRect.visible = false
	$MusicUploadScreen.visible = true


func _on_MusicUploadBtn_toggled():
	pass


func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_OptsBtn_pressed():
	$NinePatchRect.visible = false
	$OptionsMenuScreen.visible = true

func _on_PlayBtn_pressed():
	global.shots_fired = 0
	global.shots_hit = 0
	global.acc_score = 0
	global.play_origin = 'normal'
	var _status = get_tree().change_scene("res://src/Spatial.tscn")


func _on_DestressBtn_pressed():
	global.play_origin = 'destress'
	var _status = get_tree().change_scene("res://src/Spatial.tscn")
	
func _on_SafetyModeToggle_toggled(_button_pressed):
	# Initially set to false
	global.safetyMode = !global.safetyMode
 #variable will be created when script's owner is ready

func _onLineEdittextentered(textentered):
	global.playername = textentered
