extends Control

var filePath = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BrowseBtn_pressed():
	$NinePatchRect/VBoxContainer/UploadDlg.popup()
	

func _on_UploadDlg_file_selected(path):
	$NinePatchRect/VBoxContainer/LineEdit.text = path
	filePath = path


func _on_LineEdit_text_changed(new_text):
	filePath = new_text
	print(filePath)
