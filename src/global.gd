extends Node

# This is a file to hold variables that need to be read across scenes.

# Checking for normal / destress mode.
var play_origin = 'normal'

var playername = "Player"

var player_points = 0
var shots_hit = 0
var shots_fired = 0
var acc_score = 0

var histogram = []
var definition = 60

var mouseactive = false

var songplaying = false
var songchosen = false

var safetyMode = false

var vrMode = false

# func onButtonpressed():
	#gettree().changescene("res://Scenes/TestWorld.tscn")
	# print("Welcome " + str(global.playername))
