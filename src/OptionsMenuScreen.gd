extends Control

onready var screenmodes = get_node("VBoxContainer/HBoxContainer/VBoxContainer2/screenmode_options")
onready var graphics = get_node("VBoxContainer/HBoxContainer/VBoxContainer/graphics_options")
onready var resolutions = get_node("VBoxContainer/HBoxContainer/VBoxContainer2/res_options")
	
func _ready():
	_prepare_screenmodes()
	_prepare_graphics()
	_prepare_resolutions()
	if(!OS.window_fullscreen):
		screenmodes.select(1)
	
func _prepare_screenmodes():
	screenmodes.add_item("Fullscreen")
	screenmodes.add_item("Windowed")
	screenmodes.add_item("Borderless Fullscreen")
	
func _prepare_graphics():
	graphics.add_item("High")
	graphics.add_item("Medium")
	graphics.add_item("Low")
	
func _prepare_resolutions():
	resolutions.add_item("example 1920x1080")
	resolutions.add_item("example 1600x900")
	resolutions.add_item("example 1024x768")


func _on_screenmode_options_item_selected(index):
	if(index == 0):
		#toggle Fullscreen
		OS.window_borderless = false
		OS.window_fullscreen = true
	elif(index == 1):
		#toggle Windowed
		OS.window_fullscreen = false
		OS.window_borderless = false
	else:
		#toggle Borderless Windowed
		OS.window_fullscreen = false
		OS.window_borderless = true
		


func _on_VolumeSlider_value_changed(value):
	pass # Replace with function body.


func _on_value_changed(value):
	pass # Replace with function body.
