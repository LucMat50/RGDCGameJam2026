extends Firecracker

# READY
#	set detonation particles
#	super to use functions from Firecracker class
func _ready() -> void:
	super()
	detonation_type = preload("res://Scenes/VFX/explosion_cara_de_diablo.tscn")
