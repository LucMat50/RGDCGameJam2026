extends Node

# DEFAULT VARIABLES
#	Points
var candy_points: int = 0
var best_points: int = 0

#	Time
var current_time: float = 0
var best_time: float = 0

#	Lives
var lives: int = 5

# Hurt
var hold: bool = false
var hurt: bool = false

# AUDIO STREAM PLAYER
var ear_ringing = AudioStreamPlayer.new()

# CONSTANTS
const SAVEFILE = "user://savefile.save"

# READY
#	sets default variables
func _ready() -> void:
	candy_points = 0
	lives = 5
	ear_ringing.stream = load("res://Sound/UI/ear_ringing.mp3")
	add_child(ear_ringing)
	loadScore()
	GameEvents.game_over.connect(on_game_over)
	GameEvents.reset.connect(on_reset)

# PROCESS
#	checks if points are less than 0
#	does not go below 0
func _process(_delta: float) -> void:
	if candy_points < 0:
		candy_points = 0

# ON GAME OVER
#	change scene to game over on signal game over
func on_game_over():
	ear_ringing.play()
	Transition.change_scene("res://Scenes/Menus/game_over.tscn", "fade", Color(1,1,1))

# ON RESET
#	reset default values on signal reset
func on_reset():
	candy_points = 0
	current_time = 0
	lives = 5
	hold = false
	hurt = false

# SAVE SCORE
#	saves best score and time
func saveScore():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	if file:
		file.store_32(best_points)
		file.store_float(best_time)
		file.close()

# LOAD SCORE
#	loads best score and time
func loadScore():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		if file:
			best_points = file.get_32()
			best_time = file.get_float()
			file.close()

# UPDATE SCORE
#	if player gets better score or time save their score
func updateScore():
	if (candy_points > best_points):
		best_points = candy_points
		best_time = best_time
		saveScore()
		print("NEW SCORE SAVED")
		
	if (current_time > best_time):
		best_points = best_points
		best_time = current_time
		saveScore()
		print("NEW SCORE SAVED")
	
	else:
		pass
