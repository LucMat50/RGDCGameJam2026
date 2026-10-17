extends Firecracker

# INT VARIABLES
var random_color: int

# ONREADY VARIABLES
@onready var color_anim = $AnimatedSprite2D

# COLOR DICTIONARY
var color_dict: Dictionary = {
	1: ["_amarillo", preload("res://Scenes/VFX/Smoke/smokeAmarillo.tscn")],
	2: ["_azul", preload("res://Scenes/VFX/Smoke/smokeAzul.tscn")],
	3: ["_rosa", preload("res://Scenes/VFX/Smoke/smokeRosa.tscn")],
	4: ["_verde", preload("res://Scenes/VFX/Smoke/smokeVerde.tscn")]
}

# READY
#	randomizes color
func _ready() -> void:
	super()
	random_color = randi_range(1,4)
	color_anim.play("pelota_de_humo" + color_dict[random_color][0])
	detonation_type = color_dict[random_color][1]
