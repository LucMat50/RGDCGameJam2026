extends Node

# DEFAULT VARIABLES
#	Candy
var candy_points: int = 0
var candy_missed: int = 0

var best_candy_points: int = 0
var best_candy_missed: int = 0

var total_candy: int = 0

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
	candy_missed = 0
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
	candy_missed = 0
	current_time = 0
	lives = 5
	hold = false
	hurt = false

# SAVE SCORE
#	saves best score and time
func saveScore():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	if file:
		file.store_32(best_candy_points)
		file.store_32(best_candy_missed)
		file.store_32(total_candy)
		
		file.store_float(best_time)
		file.close()

# LOAD SCORE
#	loads best score and time
func loadScore():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		if file:
			best_candy_points = file.get_32()
			best_candy_missed = file.get_32()
			total_candy = file.get_32()
			
			best_time = file.get_float()
			file.close()

# UPDATE SCORE
#	if player gets better score or time save their score
func updateScore():
	# update total candy collected
	if (candy_points > 0):
		total_candy += candy_points
		saveScore()
	
	# update most candy collected
	if (candy_points > best_candy_points):
		#only updating candy_points rest stay the same
		best_candy_points = candy_points
		
		#same
		best_candy_missed = best_candy_missed
		best_time = best_time
		saveScore()
		print("NEW SCORE SAVED")
	
	# update most candy missed
	if (candy_missed > best_candy_missed):
		# change
		best_candy_missed = candy_missed
		# same
		best_candy_points = best_candy_points
		best_time = best_time
		saveScore()
		
		print("NEW SCORE SAVED")
	
	# update best survival time
	if (current_time > best_time):
		best_time = current_time
		
		best_candy_points = best_candy_points
		best_candy_missed = best_candy_missed
		saveScore()
		print("NEW SCORE SAVED")
	
	else:
		pass
