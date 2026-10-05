extends Firecracker

# INT VARIABLES
var random_color: int

# ONREADY VARIABLES
@onready var color_anim = $AnimatedSprite2D

# COLOR DICTIONARY
var color_dict: Dictionary = {
	1: "_azul",
	2: "_morado",
	3: "_rosa",
	4: "_verde"
}

func _ready() -> void:
	random_color = randi_range(1,4)
	color_anim.play("cebollita" + color_dict[random_color])
