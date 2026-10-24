extends Control

# STATS VARIABLES
var time = GameManager.best_time

# ONREADY VARIABLES
#	Candy
@onready var candy_label = $StatsContainer/Candy
@onready var candy_missed_label = $StatsContainer/CandyMissed
@onready var candy_total_label = $StatsContainer/TotalCandy
#	Time
@onready var time_label = $StatsContainer/Time

func _ready() -> void:
	var minutes := int(time) / 60
	var seconds := int(time) % 60
	var msec := int(fmod(time, 1.0) * 100)
	
	candy_label.text = "MOST CANDY COLLECTED: %s" % GameManager.best_candy_points
	candy_missed_label.text = "MOST CANDY MISSED: %s" % GameManager.best_candy_missed
	candy_total_label.text = "TOTAL CANDY COLLECTED: %s" % GameManager.total_candy
	time_label.text = "MOST TIME SURVIVED: %02d:%02d:%02d" % [minutes, seconds, msec]

func _on_back_button_pressed() -> void:
	Transition.change_scene("res://Scenes/Menus/start_menu.tscn", "slide", Color(1.0, 0.302, 0.408, 1.0))
