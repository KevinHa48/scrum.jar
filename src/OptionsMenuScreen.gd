extends Control

onready var screenmodes = get_node("VBoxContainer/HBoxContainer/VBoxContainer2/screenmode_options")
onready var graphics = get_node("VBoxContainer/HBoxContainer/VBoxContainer/graphics_options")
onready var resolutions = get_node("VBoxContainer/HBoxContainer/VBoxContainer2/res_options")
	
func _ready():
	_prepare_screenmodes()
	_prepare_graphics()
	_prepare_resolutions()
	graphics.select(1)
	get_viewport().set_shadow_atlas_size(2048)
	get_viewport().set_msaa(get_viewport().MSAA_8X)
	ProjectSettings.set_setting("rendering/quality/filters/anisotropic_filter_level", 8)
	ProjectSettings.save()
	resolutions.select(1)
	OS.set_window_size(Vector2(1600, 900))
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
	resolutions.add_item("1920x1080")
	resolutions.add_item("1600x900")
	resolutions.add_item("1024x768")


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
		
func _on_resolutions_options_item_selected(index):
	if(index == 0): #1920x1080
		OS.set_window_size(Vector2(1920, 1080))
	elif(index == 1): #1600x900
		OS.set_window_size(Vector2(1600, 900))
	else: #1024x768
		OS.set_window_size(Vector2(1024, 768))
	pass
	
func _on_graphics_options_item_selected(index):
	if(index == 0): #high
		get_viewport().set_shadow_atlas_size(8192)
		get_viewport().set_msaa(get_viewport().MSAA_16X)
		ProjectSettings.set_setting("rendering/quality/filters/anisotropic_filter_level", 16)
		ProjectSettings.save()
	elif(index == 1): #medium
		get_viewport().set_shadow_atlas_size(2048)
		get_viewport().set_msaa(get_viewport().MSAA_8X)
		ProjectSettings.set_setting("rendering/quality/filters/anisotropic_filter_level", 8)
		ProjectSettings.save()
	else: #low
		get_viewport().set_shadow_atlas_size(512)
		get_viewport().set_msaa(get_viewport().MSAA_DISABLED)
		ProjectSettings.set_setting("rendering/quality/filters/anisotropic_filter_level", 2)
		ProjectSettings.save()
	pass


func _on_VolumeSlider_value_changed(value):
	pass # Replace with function body.


func _on_value_changed(value):
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://src/TitleScreen.tscn")
