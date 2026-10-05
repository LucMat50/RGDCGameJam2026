extends Area2D

# INT VARIABLES
var candy_points: int = 0
var candy_tax: int = 0
var firecracker_points: int = 0

# ARRAY VARIABLES
var candy_inventory: Array = []
var firecracker_inventory: Array = []

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
			candy_points += 1
			print("Candy: " + str(candy_points))
			candy_inventory.append(body)
			body.queue_free()
			
		elif body.is_in_group("Firecracker"):
			if body.has_signal("boom"):
				body.boom.connect(_on_boom)
			firecracker_points += 1
			print("Firecracker: " + str(firecracker_points))
			body.detonation()
			candy_points -= candy_tax
			print("Candy: " + str(candy_points))
			firecracker_inventory.append(body)

func _on_boom(_danger: int, tax: int, _type: String):
	candy_tax = tax
