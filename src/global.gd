extends Node

# This is a file to hold variables that need to be read across scenes.

# Checking for normal / destress mode.
var play_origin = 'normal'

var playername = "Player"

var player_points = 0

func _onLineEdittextentered(newtext):
	playername = newtext
	global.playername = newtext
	

# func onButtonpressed():
	#gettree().changescene("res://Scenes/TestWorld.tscn")
	# print("Welcome " + str(global.playername))
