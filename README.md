[![Build Godot Project](https://github.com/KevinHa48/scrum.jar/actions/workflows/build.yml/badge.svg)](https://github.com/KevinHa48/scrum.jar/actions/workflows/build.yml)

# scrum.jar
This project is a virtual reality game involving auditory and visual stimulations to provide a de-stressing experience for stressed industry professionals.
This is an interactive music visualization game which uses a variety of inputs such as traditional computer inputs (keyboard, mouse) or virtual reality controls (motion controller) and soothing music and visuals to calm individuals and invoke a sense of relaxation through experiential immersion.
The gameplay is simple to learn for everyone to maximize interactivity while minimizing stress. It uses a combination of both psychedelic and music therapy to achieve our project goal and offer a simple game that will help others to improve their mental state.

## Setting Up Development Environment
- Install latest stable version of the Godot game engine
- Pull this project
- Import this project's root directory into Godot
- Open the scene you wish you develop or test for (currently music visualizer and spatial vr test)
- Run the scene at the top right of the Godot UI.

## Requirements
- OpenVR implementation running in the background (usually SteamVR running via Steam)

## Usage
- Download the executable for your platform (Windows and Linux are currently supported)
    - Windows: https://github.com/KevinHa48/scrum.jar/releases/download/s1/Client.-.windows.zip
    - Linux: https://github.com/KevinHa48/scrum.jar/releases/download/s1/Client.-.linux.zip
- Extract the zip archive
- Run the executable (currently named `example`)

## Testing
Testing is currently implemented using the [Built Godot Project](https://github.com/josephbmanley/build-godot-action) GitHub Action to attempt to build the project and create packaged binaries for use by scrum.jar developers and its end users, implementing continuous integration and continuous development to ensure each commit allows the continued operation of the project.
The status of various features of the game are also tracked in `test.py` which is used by developers and testers to determine if the working prototype of the game is functioning as determined.

## Team Members
- [Kevin Ha](https://github.com/KevinHa48) (Scrum Master)
- [Jackson Perry](https://github.com/jackperry2187)
- [Tyler Kaminski](https://github.com/durcor)
- [Jacob Gerega](https://github.com/jgerega107)
- [Yakov Kazinets](https://github.com/yakovkazinets)
- [William Kastell](https://github.com/liamsusername)
- [Matthew Oyales](https://github.com/moyales)
