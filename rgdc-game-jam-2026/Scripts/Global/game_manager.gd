extends Node

# DEFAULT VARIABLES
#	Points
var candy_points: int = 0
var current_time: float = 0

#	Lives
var lives: int = 5

# Hurt
var hold: bool = false
var hurt: bool = false

func _ready() -> void:
	candy_points = 0
	lives = 5
	GameEvents.game_over.connect(on_game_over)
	GameEvents.reset.connect(on_reset)

func _process(_delta: float) -> void:
	if candy_points < 0:
		candy_points = 0

func on_game_over():
	Transition.change_scene("res://Scenes/Menus/game_over.tscn", "fade", Color(1,1,1))

func on_reset():
	candy_points = 0
	current_time = 0
	lives = 5
	hold = false
	hurt = false
	
	
