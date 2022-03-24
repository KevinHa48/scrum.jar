extends Control

var filePath = ""
var musicDir = "user://music/"
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

func _on_AddGenreBtn_pressed():
	var file = File.new()
	if file.file_exists("savedsongs.csv"):
		file.open("savedsongs.csv", File.READ_WRITE)
		var tempFile = File.new()
		tempFile.open("temp.csv", File.WRITE)
		
		var entry;
		while !file.eof_reached():
			entry = file.get_csv_line()
			if entry[0] == filePath:
				entry.append($NinePatchRect/VBoxContainer/GenreInput.text)
			tempFile.store_csv_line(entry)
		
		if file.eof_reached() && entry[0] != filePath:
			tempFile.store_csv_line(
				PoolStringArray(
					[filePath, $NinePatchRect/VBoxContainer/GenreInput.text]))
		
		file.close()
		tempFile.close()
		
		var dir = Directory.new()
		dir.remove("res://savedsongs.csv")
		dir.rename("res://temp.csv", "res://savedsongs.csv")		
	else:
		file.open("savedsongs.csv", File.WRITE_READ)
		var dir = Directory.new()

func _on_UploadDlg_file_selected(path):
	$NinePatchRect/VBoxContainer/FilePathInput.text = path
	filePath = path


func _on_LineEdit_text_changed(new_text):
	filePath = new_text


func _on_ConfirmBtn_pressed():
	var file = File.new()
	file.open(filePath, File.READ)
	if file.file_exists(filePath):
		file.open(filePath, File.READ)
		var audio = determineFileType()
		if audio:
			audio.set_data(file.get_buffer(file.get_len()))
			# Add file to musicDir
			addToMusicDir()
			$AudioStreamPlayer.set_stream(audio)
			$AudioStreamPlayer.play()
			# hide()
		else:
			$NinePatchRect/VBoxContainer/LineEdit.text = "Given file cannot be played."


func determineFileType():
	if filePath.ends_with(".ogg"):
		return AudioStreamOGGVorbis.new()
	elif filePath.ends_with(".wav"):
		return AudioStreamSample.new()
	elif filePath.ends_with(".mp3"):
		return AudioStreamMP3.new()


# Attempting to add file to User data.
func addToMusicDir():
	var dir = Directory.new()
	dir.make_dir(musicDir)
	dir.copy(filePath, musicDir + filePath.get_file())
