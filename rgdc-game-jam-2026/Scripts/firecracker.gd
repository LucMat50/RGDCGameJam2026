class_name Firecracker
extends RigidBody2D

# INT VARIABLES
var random_firecracker: int

# EXPORT VARIABLES
@export_category("Danger Category")
@export var danger_level: int
@export var candy_tax: int

@export_category("Detonation")
@export var detonation_time: float

# ONREADY VARIABLES
@onready var detonation_timer = $Timer
