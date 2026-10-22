extends Control

var points = GameManager.best_points
var time = GameManager.best_time

@onready var candy_label = $StatsContainer/Candy
@onready var time_label = $StatsContainer/Time

func _ready() -> void:
	var minutes := int(time) / 60
	var seconds := int(time) % 60
	var msec := int(fmod(time, 1.0) * 100)
	
	candy_label.text = "MOST CANDY COLLECTED: %s" % GameManager.best_points
	time_label.text = "BEST TIME: %02d:%02d:%02d" % [minutes, seconds, msec]

func _on_back_button_pressed() -> void:
	Transition.change_scene("res://Scenes/Menus/start_menu.tscn", "slide", Color(1,1,1))
