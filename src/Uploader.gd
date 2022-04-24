extends Control

var filePath = ""
var musicDir = "user://music/"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BrowseBtn_pressed():
	$NinePatchRect/UploadDlg.access = 2
	$NinePatchRect/UploadDlg.popup()


func _on_UploadedBtn_pressed():
	var dir = Directory.new()
	if dir.dir_exists(musicDir):
		$NinePatchRect/UploadDlg.access = 1
		$NinePatchRect/UploadDlg.current_dir = musicDir
		$NinePatchRect/UploadDlg.current_path = musicDir
		$NinePatchRect/UploadDlg.popup()


func _on_AddGenreBtn_pressed():
	var file = File.new()
	var fileName = filePath.get_file()
	
	if file.file_exists(filePath):
		addToMusicDir()
	
	if file.file_exists("user://savedsongs.txt"):
		file.open("user://savedsongs.txt", File.READ_WRITE)
		var tempFile = File.new()
		tempFile.open("user://temp.txt", File.WRITE)
		
		var entry;
		var fileExists = false
		while !file.eof_reached():
			entry = file.get_csv_line()
			if entry.size() > 0:
				if entry[0] == fileName:
					entry.append($NinePatchRect/VBoxContainer/GenreInput.text)
					fileExists = true
				tempFile.store_csv_line(entry)
		
		if file.eof_reached() && !fileExists:
			tempFile.store_csv_line(
				PoolStringArray(
					[fileName, $NinePatchRect/VBoxContainer/GenreInput.text]))
		
		file.close()
		tempFile.close()
		
		var dir = Directory.new()
		dir.remove("user://savedsongs.txt")
		dir.rename("user://temp.txt", "user://savedsongs.txt")
	else:
		file.open("user://savedsongs.txt", File.WRITE_READ)
		var dir = Directory.new()
		dir.open(musicDir)
		dir.list_dir_begin(true, true)
		
		var entry = dir.get_next()
		while entry != "":
			if entry == fileName:
				file.store_csv_line(
					PoolStringArray(
						[fileName, $NinePatchRect/VBoxContainer/GenreInput.text]))
			else:
				file.store_csv_line(
					PoolStringArray(
						[entry]
					)
				)
			
			entry = dir.get_next()
			
		file.close()
			

func _on_UploadDlg_file_selected(path):
	$NinePatchRect/VBoxContainer/FilePathInput.text = path
	filePath = path
	$NinePatchRect/VBoxContainer/Genres.text = "Genres: "


func _on_LineEdit_text_changed(new_text):
	filePath = new_text
	$NinePatchRect/VBoxContainer/Genres.text = "Genres: "

func _on_ConfirmBtn_pressed():
	var file = File.new()
	file.open(filePath, File.READ)
	var fileName = filePath.get_file()
	if file.file_exists(filePath):
		file.open(filePath, File.READ)
		var audio = determineFileType()
		if audio:
			audio.set_data(file.get_buffer(file.get_len()))
			# Add file to musicDir if it isn't already there
			if not file.file_exists(musicDir + fileName):
				addToMusicDir()
			$AudioStreamPlayer.set_stream(audio)
			$AudioStreamPlayer.play()
			global.songplaying = true
			displayGenres()
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			global.mouseactive = true
		else:
			$NinePatchRect/VBoxContainer/Genres.text = "Given file cannot be played."


func determineFileType():
	if filePath.ends_with(".ogg"):
		return AudioStreamOGGVorbis.new()
	elif filePath.ends_with(".wav"):
		return AudioStreamSample.new()
	elif filePath.ends_with(".mp3"):
		return AudioStreamMP3.new()

func displayGenres():
	$NinePatchRect/VBoxContainer/Genres.text = "Genres: "
	var file = File.new()
	file.open("user://savedsongs.txt", file.READ)
	while !file.eof_reached():
		var entry = file.get_csv_line()
		if entry[0] == filePath.get_file():
			for e in range(1, entry.size() - 1):
				$NinePatchRect/VBoxContainer/Genres.text += entry[e] + ", "
			$"NinePatchRect/VBoxContainer/Genres".text += entry[entry.size() - 1]
			
	
# Attempting to add file to User data.
func addToMusicDir():
	var dir = Directory.new()
	dir.make_dir(musicDir)
	dir.copy(filePath, musicDir + filePath.get_file())
