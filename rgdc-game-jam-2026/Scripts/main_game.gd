extends Node2D

# READY
#	unpause tree and mute audio to fade in
func _ready() -> void:
	get_tree().paused = false
	$BackgroundMusic.volume_db = -80
	fade_in()

# FADE IN
#	fades music in to 0.0 volume over 2 seconds
func fade_in():
	var tween = create_tween()
	tween.tween_property($BackgroundMusic, "volume_db", 0.0, 2)
