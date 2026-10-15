extends Control

@onready var default = $Default
@onready var dead = $Dead

func _ready() -> void:
	default.show()
	dead.hide()

func set_alive():
	default.show()
	dead.hide()

func set_dead():
	default.hide()
	dead.show()
