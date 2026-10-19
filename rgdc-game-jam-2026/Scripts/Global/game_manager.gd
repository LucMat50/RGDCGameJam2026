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

func _process(_delta: float) -> void:
	if candy_points < 0:
		candy_points = 0
