class_name Firecracker
extends RigidBody2D

# INT VARIABLES
var random_firecracker: int
var candy_tax: int
var danger_level: int

# STRING VARIABLES
var anim_color: String

# ONREADY VARIABLES
@onready var firecracker_anim = $AnimatedSprite2D
@onready var firecracker_collision = $CollisionShape2D

# DICTIONARIES
# Firecracker Animations
var firecracker_dict: Dictionary = {
	1: "cara_de_diablo",
	2: "chifladores",
	3: "pelota_de_humo_",
	4: "cebollitas_",
	5: "paloma",
	6: "abejita_"
}

# Firecracker Colors 
#	only for certain firecrackers
var color_dict: Dictionary = {
	1: ["azul", "morada", "rosa"],
	3: ["amarillo", "azul", "rosa", "verde"],
	6: ["azul", "morada", "rosa"]
}

# Collision
# [shape, size, position]
var collision_dict: Dictionary = {
	1: [],
	2: [RectangleShape2D.new(), Vector2(50,50), Vector2(1,36)],
	3: [CircleShape2D.new(), 50, Vector2(1,57)],
	4: [RectangleShape2D.new(), Vector2(50,50), Vector2(0,0)],
	5: [],
	6: [RectangleShape2D.new(), Vector2(50,50), Vector2(-5,53)]
}

# Candy Tax
var tax: Dictionary = {
	1: "",
	2: "",
	3: "",
	4: "",
	5: "",
	6: ""
}

# Danger Level
# Lowest: 1 - Highest: 3
var danger_dict: Dictionary = {
	1: 3,
	2: 2,
	3: 1,
	4: 1,
	5: 2,
	6: 2
}

func _ready() -> void:
	random_firecracker = randi_range(1, 6)
	anim_color = ""
	
	match random_firecracker:
		1: 
			anim_color = color_dict[1][randi_range(0, 2)]
		3: 
			anim_color = color_dict[3][randi_range(0, 2)]
		6: 
			anim_color = color_dict[6][randi_range(0, 3)]
	
	var anim_name = firecracker_dict[random_firecracker] + anim_color
	firecracker_anim.play(anim_name)
