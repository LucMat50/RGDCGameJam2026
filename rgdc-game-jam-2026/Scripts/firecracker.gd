class_name Firecracker
extends AnimatedSprite2D

# INT VARIABLES
var random_firecracker: int
var candy_tax: int
var danger_level: int

# ONREADY VARIABLES
@onready var firecracker_anim = $AnimatedSprite2D
@onready var firecracker_collision = $CollisionShape2D

# DICTIONARIES
# Firecracker Animations
var firecracker_dict: Dictionary = {
	1: "cara_de_diablo",
	2: "chifladores",
	3: "bomba_de_humo",
	4: "cebollitas",
	5: "paloma",
	6: "abejita"
}

# Collision
# [shape, size]
var collision_dict: Dictionary = {
	1: [],
	2: [],
	3: [],
	4: [],
	5: [],
	6: []
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
var danger_dict: Dictionary = {
	1: "",
	2: "",
	3: "",
	4: "",
	5: "",
	6: ""
}
