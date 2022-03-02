extends Control

var filePath = ""
var musicDir = ""
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
	$NinePatchRect/UploadDlg.popup()
	

func _on_UploadDlg_file_selected(path):
	$NinePatchRect/VBoxContainer/LineEdit.text = path
	filePath = path

func _on_LineEdit_text_changed(new_text):
	filePath = new_text


func _on_ConfirmBtn_pressed():
	var file = File.new()
	file.open(filePath, File.READ)
	if file.file_exists(filePath):
		file.open(filePath, File.READ)
		#var audio = AudioStreamMP3.new()
		var audio = determineFileType()
		audio.set_data(file.get_buffer(file.get_len()))
		$NinePatchRect/AudioTester.set_stream(audio)
		$NinePatchRect/AudioTester.play()
		
func determineFileType():
	if filePath.ends_with(".ogg"):
		return AudioStreamOGGVorbis.new()
	elif filePath.ends_with(".wav"):
		return AudioStreamSample.new()
	else:
		return AudioStreamMP3.new()
		
			
	


