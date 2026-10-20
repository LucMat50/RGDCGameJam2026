extends Control

var tween: Tween

@onready var candy_label = $VBoxContainer/StatsContainer/Candy
@onready var time_label = $VBoxContainer/StatsContainer/Time

func _ready() -> void:
	var minutes := int(GameManager.current_time) / 60
	var seconds := int(GameManager.current_time) % 60
	var msec := int(fmod(GameManager.current_time, 1.0) * 100)
	
	candy_label.text = "CANDY: %s" % GameManager.candy_points
	time_label.text = "TIME: %02d:%02d:%02d" % [minutes, seconds, msec]

func _on_retry_button_pressed() -> void:
	GameEvents.reset.emit()
	Transition.change_scene("res://Scenes/main_game.tscn", "slide", Color(1,1,1))

func _on_back_button_pressed() -> void:
	GameEvents.reset.emit()
	Transition.change_scene("res://Scenes/Menus/start_menu.tscn", "slide", Color(1,1,1))

func _on_quit_button_pressed() -> void:
	get_tree().quit()
