#!/usr/bin/env python3

tests = [
    "The visuals the user sees should be based on the audio the user hears",
    "The user should be able to provide their own music or audio files",
    "The user should be prompted when they start the program to provide their own audio file",
    "The user will be prompted with a file selection window where they can select a proper audio file",
    "The user will receive a warning if they try to select an audio file of improper format.",
    "The user will confirm their selection of audio file, which will begin the audio playback in the program.",
    "The user should should be allowed to select .ogg, .wav, and .mp3 files",
    "The user will be presented with visuals that mirrors the audio played and visuals on screen",
    "The user will be able to interact with the gameplay that is based on the audio chosen",
    "The user will be given a score based on their performance during the gameplay",
    "The user should be able to choose which difficulty level they want their gameplay experience to be",
    "User should experience different difficulty based on difficulty selected",
    "The user should be allowed to see their performance statistics for the current song",
    "The user should be allowed to see their performance statistics throughout their playtime",
    "There should be a mode the user can toggle that disables gameplay, allowing them to just watch the visuals and listen to the music",
    "The user will be able to modify their in-game controls and how they bind to the devices used to interact with the game.",
    "The user should be able to choose among a selection of pre-loaded songs if they have not provided their own music files yet.",
    "The user should be able to choose between a list of songs they have loaded into the game",
    "The songs should be marked with one or more genre tags such that users can select songs based on these categories",
    "The visuals should have a psychedelic, trip-like aesthetic that use calming colors to improve mental comfort",
    "The user should be able to adjust the offset of visuals in case of hardware or computer performance related issues",
    "The user should be able to set their nickname",
    "The user should be able to view high score statistics of current and other nicknamed user",
    "The user should be able to input a nickname that corresponds with a high score",
    "The user should be able to move around and view the environment",
    "The user should be able to view a variety of randomly/procedurally generated colors from the gameplay objects",
    "The user should be able to toggle a mode that changes colors at a slower pace, to prevent seizures from those who are inclined to them",
    "The user should be able to open an options menu to change their options",
    "The user should be able to change the resolution for the game",
    "The user should be able to change the volume for the game",
    "The user can press a button to quit the game",
    "The user should have the game pause when they enter the options menu",
    "The user should view a title srceen upon startup",
    "The user should be able to return to the title screen from gameplay",
    "The user should no longer see any gameplay reacting to audio when they back out to the title screen",
    "The user should see no gameplay at the end of the song duration, even if unrelated audio may still be playing ",
    "The user should be presented with a summary screen with their score at the end of gameplay",
    "The user should be presented with a button asking to retry the previous song at the end of gameplay",
    "The user should be presented with a button asking to return to song selection at the end of gameplay",
    "The user should be able to choose a mode where they can play their music without any visuals or gameplay",
    "The user should be able to move around using a keyboard and mouse",
    "The user should be able to interact with the gameplay using keyboard and mouse",
    "The user should be able to interact with the gameplay using VR",
    "The user should be presented with an immersive background to gameplay",
    "The user should gain experience points after each song completed",
    "The user should gain experience points based on the score they recieved on the song they played",
    "Each level, the user should level up upon gaining enough experience",
    "The user should unlock difficulty modes based on their curernt level",
    "The user should always their scores saved and be able to pull them up even after the game is closed and restarted",
    "The user should hear the last played song played on the title screen",
    "The user should be able to change from fullscreen to windowed to borderless mode in the options menu",
    "The user should be able to play the game in a windowed screen without the border",
    "The user should be able to enter a fullscreen view, toggleable by pressing F11",
    "The user should be able to play the game in a windowed screen",
    "The user's gameplay should generate sound effects",
    "The user can change the volume of sound effects generated by gameplay",
]

passed_tests = 0

for t in tests:
    print(t)
    if input("[y/n]: ") == "y":
        print("Passed")
        passed_tests += 1
    else:
        print("Failed")
    print()

print("Passed {}/{} tests".format(passed_tests, len(tests)))
