extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuInterface/AudioPlayer
	$TitleScreen.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	

# Switch back to the main menu.
func _on_MainMenu_pressed():
	$MenuInterface.visible = false
	$TitleScreen.visible = true

# Switch to the upload music screen.
func _on_Upload_pressed():
	$MenuInterface.visible = false
	$MusicUploadScreen.visible = true

# Goes to one of the preloaded songs and plays it.
func play_song(path):
	var file = File.new()
	file.open(path, file.READ)
	var audio = AudioStreamMP3.new()
	audio.set_data(file.get_buffer(file.get_len()))
	$AudioStreamPlayer.set_stream(audio)
	$AudioStreamPlayer.play()

func _on_PlaySong1_pressed():
	play_song("res://assets/preloaded_songs/acoustic.mp3")

func _on_PlaySong2_pressed():
	play_song("res://assets/preloaded_songs/dawn.mp3")

func _on_PlaySong3_pressed():
	play_song("res://assets/preloaded_songs/figaro.mp3")


func _on_PlaySong4_pressed():
	play_song("res://assets/preloaded_songs/jazz.mp3")

func _on_PlaySong5_pressed():
	play_song("res://assets/preloaded_songs/lofi.mp3")
