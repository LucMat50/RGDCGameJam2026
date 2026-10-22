extends Area2D

# INT VARIABLES
var candy_tax: int = 0
var firecracker_points: int = 0

# TWEEN
var tween: Tween

# AUDIO STREAM PLAYER
var bag_sound = AudioStreamPlayer.new()

# READY
func _ready() -> void:
	GameEvents.boom.connect(_on_boom)
	mouse_entered.connect(on_hover)
	mouse_exited.connect(exit_hover)
	
	bag_sound.stream = load("res://Sound/drop.mp3")

# ON INPUT EVENT
#	calls drop if mouse not pressed
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.is_pressed():
			drop()

# DROP
#	updates candy/firecracker points and inventory
#	deletes candy/firecracker
func drop():
	for body in get_overlapping_bodies():
		if body.is_in_group("Candy"):
			GameManager.candy_points += 1
			print("Candy: " + str(GameManager.candy_points))
			body.queue_free()
			
		elif body.is_in_group("Firecracker"):
			firecracker_points += 1
			GameManager.candy_points -= candy_tax
			print("Firecracker: " + str(firecracker_points))
			print("Candy: " + str(GameManager.candy_points))
			body.detonation()

# ON BOOM
#	get specified candy_tax from firecracker
func _on_boom(_danger: int, tax: int):
	print("BOOM RECEIVED")
	candy_tax = tax

# ON HOVER
#	makes sprite bigger when hovering
func on_hover():
	bag_sound.play()
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.02, 1.02), 0.2)

# EXIT HOVER
#	returns to normal size after hover
func exit_hover():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.0, 1.0), 0.2)
