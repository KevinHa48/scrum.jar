extends Control

var dir = Directory.new()
var musicDir = "user://music/"
var song_pos = 0
var song_arr = []
var current_song_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if dir.open(musicDir) == OK:
		dir.list_dir_begin(true, true)
		var current_song = dir.get_next()
		while current_song != "":
			song_arr.append(musicDir + current_song)
			current_song = dir.get_next()
		if !song_arr.size():
			updateLabel("No uploaded music, please upload from the Main Menu")
			return
		else:
			playSong()
	else:
		updateLabel("Error Opening Music Directory")

func updateLabel(text):
	$MarginContainer/VBoxContainer/SongInfoContainer/SongNameLbl.text = text

func playSong():
	var current_song = song_arr[current_song_index]
	var file = File.new()
	file.open(current_song, File.READ)
	var audio = determineFileType(current_song)
	audio.set_data(file.get_buffer(file.get_len()))
	$AudioStreamPlayer.set_stream(audio)
	$AudioStreamPlayer.play()
	updateLabel(current_song)

func _on_SeekFowardBtn_pressed():
	if(current_song_index < song_arr.size() - 1):
		current_song_index += 1
	else:
		current_song_index = 0
	playSong()

func _on_SeekBackwardsBtn_pressed():
	if(current_song_index > 0):
		current_song_index -= 1
	else:
		current_song_index = song_arr.size() - 1
	playSong()


func _on_PausePlayBtn_toggled(button_pressed):
	if(button_pressed):
		song_pos = $AudioStreamPlayer.get_playback_position()
		$AudioStreamPlayer.stop()
	else:
		$AudioStreamPlayer.play(song_pos)

func determineFileType(current_song):
	if current_song.ends_with(".ogg"):
		return AudioStreamOGGVorbis.new()
	elif current_song.ends_with(".wav"):
		return AudioStreamSample.new()
	elif current_song.ends_with(".mp3"):
		return AudioStreamMP3.new()
