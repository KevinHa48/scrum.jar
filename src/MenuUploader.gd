extends Control

var filePath = ""
var musicDir = "user://music/"

onready var _uploadDiag = $NinePatchRect/UploadDlg
onready var _genre_input = $NinePatchRect/VBoxContainer/GenreInput
onready var _genreLbl = $NinePatchRect/VBoxContainer/Genres
onready var _audioStream = $AudioStreamPlayer
onready var _filePathInput = $NinePatchRect/VBoxContainer/FilePathInput
onready var _popup = $PopupDialog
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
	_uploadDiag.access = 2
	_uploadDiag.popup()


func _on_UploadedBtn_pressed():
	var dir = Directory.new()
	if dir.dir_exists(musicDir):
		_uploadDiag.access = 1
		_uploadDiag.current_dir = musicDir
		_uploadDiag.current_path = musicDir
		_uploadDiag.popup()


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
					entry.append(_genre_input.text)
					fileExists = true
				tempFile.store_csv_line(entry)
		
		if file.eof_reached() && !fileExists:
			tempFile.store_csv_line(
				PoolStringArray(
					[fileName, _genre_input.text]))
		
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
						[fileName, _genre_input.text]))
			else:
				file.store_csv_line(
					PoolStringArray(
						[entry]
					)
				)
			
			entry = dir.get_next()
			
		file.close()
			

func _on_UploadDlg_file_selected(path):
	_filePathInput.text = path
	filePath = path
	_genreLbl.text = "Genres: "


func _on_LineEdit_text_changed(new_text):
	filePath = new_text
	_genreLbl.text = "Genres: "

func _on_ConfirmBtn_pressed():
	var file = File.new()
	file.open(filePath, File.READ)
	var fileName = filePath.get_file()
	if file.file_exists(filePath):
		file.open(filePath, File.READ)
		var audio = determineFileType()
		if audio:
			_genreLbl.text = "Genres: "
			audio.set_data(file.get_buffer(file.get_len()))
			# Add file to musicDir if it isn't already there
			if not file.file_exists(musicDir + fileName):
				addToMusicDir()
			displayGenres()
			_popup.show()
			hide()
		else:
			_genreLbl.text = "Given file cannot be uploaded."


func determineFileType():
	if filePath.ends_with(".ogg"):
		return AudioStreamOGGVorbis.new()
	elif filePath.ends_with(".wav"):
		return AudioStreamSample.new()
	elif filePath.ends_with(".mp3"):
		return AudioStreamMP3.new()

func displayGenres():
	_genreLbl.text = "Genres: "
	var file = File.new()
	
	# Check since savedsongs.txt does not exist on a clean project state.
	if file.file_exists("user://savedsongs.txt"):
		file.open("user://savedsongs.txt", File.READ)
		while !file.eof_reached():
			var entry = file.get_csv_line()
			if entry[0] == filePath.get_file():
				for e in range(1, entry.size() - 1):
					_genreLbl.text += entry[e] + ", "
				_genreLbl.text += entry[entry.size() - 1]
	else:
		file.open("user://savedsongs.txt", File.WRITE)
			
	
# Attempting to add file to User data.
func addToMusicDir():
	var dir = Directory.new()
	dir.make_dir(musicDir)
	dir.copy(filePath, musicDir + filePath.get_file())


func _on_BackBtn_pressed():
	var _status = get_tree().change_scene("res://src/TitleScreen.tscn")
