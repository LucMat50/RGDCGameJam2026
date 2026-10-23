extends Control

# ONREADY VARIABLES
@onready var dale = $DaleDaleDale

# ON PLAY BUTTON PRESSED
#	emit reset signal
#	change scene to the main game
func _on_play_button_pressed() -> void:
	GameEvents.reset.emit()
	fade_out()
	Transition.change_scene("res://Scenes/main_game.tscn", "slide", Color(1.0, 0.302, 0.408, 1.0))

# ON STATS BUTTON PRESSED
#	change scene to the stats menu
func _on_stats_button_pressed() -> void:
	fade_out()
	Transition.change_scene("res://Scenes/Menus/stats_menu.tscn", "slide", Color(1.0, 0.302, 0.408, 1.0))

# ON QUIT BUTTON PRESSED
#	quits game
func _on_quit_button_pressed() -> void:
	fade_out()
	get_tree().quit()

# FADE OUT
#	fades music out
func fade_out():
	var tween = create_tween()
	
	tween.tween_property(dale, "volume_db", -80.0, 1)
	await tween.finished
	dale.stop()
	dale.volume_db = 0.0
