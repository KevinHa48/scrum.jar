extends Control


func _ready():
	_prepare_screenmodes()
	_prepare_graphics()
	_prepare_resolutions()
	

func _prepare_screenmodes():
	var screenmodes = get_node("HBoxContainer/VBoxContainer2/screenmode_options")
	screenmodes.add_item("Fullscreen")
	screenmodes.add_item("Windowed")
	screenmodes.add_item("Borderless Fullscreen")
	
func _prepare_graphics():
	var graphics = get_node("HBoxContainer/VBoxContainer/graphics_options")
	graphics.add_item("High")
	graphics.add_item("Medium")
	graphics.add_item("Low")
	
func _prepare_resolutions():
	var resolutions = get_node("HBoxContainer/VBoxContainer2/res_options")
	resolutions.add_item("example 1920x1080")
	resolutions.add_item("example 1600x900")
	resolutions.add_item("example 1024x768")
