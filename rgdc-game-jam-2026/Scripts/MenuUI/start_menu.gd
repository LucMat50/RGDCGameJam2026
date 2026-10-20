extends Control

func _on_play_button_pressed() -> void:
	Transition.change_scene("res://Scenes/main_game.tscn", "slide", Color(1,1,1))

func _on_stats_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
