class_name Firecracker
extends AnimatedSprite2D

# INT VARIABLES
var random_firecracker: int

# ONREADY VARIABLES
@onready var firecracker_anim = $AnimatedSprite2D
@onready var firecracker_collision = $CollisionShape2D

# DICTIONARIES
var rocket_dict: Dictionary = {
	1: "cara_de_diablo",
	2: "chifladores",
	3: "bomba_de_humo",
	4: "cebollitas",
	5: "paloma",
	6: "abejita"
}
