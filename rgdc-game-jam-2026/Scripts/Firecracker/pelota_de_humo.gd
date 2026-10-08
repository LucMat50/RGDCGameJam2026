extends Firecracker

# INT VARIABLES
var random_color: int

# ONREADY VARIABLES
@onready var color_anim = $AnimatedSprite2D

# COLOR DICTIONARY
var color_dict: Dictionary = {
	1: "_amarillo",
	2: "_azul",
	3: "_rosa",
	4: "_verde"
}

func _ready() -> void:
	random_color = randi_range(1,4)
	color_anim.play("pelota_de_humo" + color_dict[random_color])
