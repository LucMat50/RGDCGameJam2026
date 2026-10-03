extends Area2D

# INT VARIABLES
var candy_points: int = 0
var rocket_tax: int = 0

# ARRAY VARIABLES
var candy_inventory: Array = []
var rocket_inventory: Array = []

# READY
#	detects bodies in 1st frame
func _ready() -> void:
	for body in get_overlapping_bodies():
		if body.is_in_group("Candy"):
			_on_body_entered(body)

# ON BODY ENTERED
#	updates points and inventory
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Candy"):
		candy_points += 1
		candy_inventory.append(body)
		body.queue_free()
		
	elif body.is_in_group("Rocket"):
		candy_points -= rocket_tax
		rocket_inventory.append(body)
		body.queue_free()
