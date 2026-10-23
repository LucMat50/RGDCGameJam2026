extends CanvasLayer

# READY
#	hide menu and set to unpaused
func ready():
	visible = false
	get_tree().paused = false

# PROCESS
#	checks if esc pressed and game is not paused 
#	if they are then pause
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()

# RESUME
#	hide menu and unpause game
func resume():
	visible = false
	get_tree().paused = false

# PAUSE
#	show menu and pause game
func pause():
	$PauseSound.play()
	visible = true
	get_tree().paused = true

# ON RESUME BUTTON PRESSED
#	call resume
func _on_resume_button_pressed() -> void:
	resume()

# ON BACK BUTTON PRESSED
#	call resume and go to start menu
func _on_back_button_pressed() -> void:
	resume()
	Transition.change_scene("res://Scenes/Menus/start_menu.tscn", "slide", Color(1.0, 0.302, 0.408, 1.0))

# ON RESET BUTTON PRESSED
#	reset game
func _on_reset_button_pressed() -> void:
	GameEvents.reset.emit()
	await get_tree().create_timer(0.05).timeout
	get_tree().reload_current_scene()
