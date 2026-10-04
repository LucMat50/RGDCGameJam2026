class_name Candy
extends RigidBody2D

# INT VARIABLES
var random_candy: int

# ONREADY VARIABLES
@onready var candy_anim = $AnimatedSprite2D
@onready var candy_collision = $CollisionShape2D

# DICTIONARIES
# Candy Animation
var candy_dict: Dictionary = {
	1: "bocadin",
	2: "bubulubu",
	3: "mamut",
	4: "mazapan",
	5: "pelon",
	6: "pulparindo"
}

# Collision
# [shape, size]
var collision_dict: Dictionary = {
	1: [RectangleShape2D.new(), Vector2(500, 150)],
	2: [RectangleShape2D.new(), Vector2(600, 130)],
	3: [RectangleShape2D.new(), Vector2(400, 450)],
	4: [CircleShape2D.new(), 160],
	5: [RectangleShape2D.new(), Vector2(200, 550)],
	6: [RectangleShape2D.new(), Vector2(500, 210)]
}

# READY
# 	randomizes candy
func _ready() -> void:
	# random integer number 1 - 6
	random_candy = randi_range(1, 6)
	# get animation from dictionary key
	candy_anim.play(candy_dict[random_candy])
	
	# get shape from dictionary key
	candy_collision.shape = collision_dict[random_candy][0]
	
	if candy_collision.shape is RectangleShape2D:
		# get width:height from dictionary key
		candy_collision.shape.size = collision_dict[random_candy][1]
		
	elif candy_collision.shape is CircleShape2D:
		# get radius from dictionary key
		candy_collision.shape.radius = collision_dict[random_candy][1]
