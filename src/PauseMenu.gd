extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed('pause'):
		set_is_paused(self.is_paused)

func set_is_paused(value):
	is_paused = !is_paused;
	visible = is_paused
	global.visualizer = !is_paused
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		global.mouseactive = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		global.mouseactive = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ResumeBtn_pressed():
	set_is_paused(self.is_paused)


func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_ResetBtn_pressed():
	self.is_paused = false
	
func _on_TitleBtn_pressed():
	get_tree().change_scene("res://src/TitleScreen.tscn")
