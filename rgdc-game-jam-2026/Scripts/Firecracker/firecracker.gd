class_name Firecracker
extends RigidBody2D

# INT VARIABLES
var random_firecracker: int

# EXPORT VARIABLES
# Danger Category
@export_category("Danger Category")
#	Level 0/1: little to no harm
#	Level 2: Stun
#	Level 3: Will tear someone's limb off
@export var danger_level: int
@export var stun_time: float

# amount of candy lost if put in inventory or blown up
@export var candy_tax: int

# Detonation
@export_category("Detonation")
# time before detonating after held
@export var detonation_time: float
@export var spark_offset: Vector2
@export var detonation_type: String
@export var detonation_boom: AudioStreamPlayer

# ONREADY VARIABLES
@export var detonation_timer: Timer

# CONSTANT VARIABLES
const SPARK_PARTICLES = preload("res://Scenes/VFX/spark.tscn")

# SIGNALS
signal boom(danger: int, tax: int, type: String)

# READY
# starts detonation timer
func _ready() -> void:
	spark_particles()
	detonation_timer.start(detonation_time)
	detonation_timer.timeout.connect(detonation)

func _process(_delta: float) -> void:
	missed()

# SPARK PARTICLES
#	instantiate and set spark at beginning of the wick
func spark_particles():
	var spark = SPARK_PARTICLES.instantiate()
	spark.position = spark_offset
	self.add_child(spark)

# MISSED
# 	blow up if falls to the bottom of the screen
func missed():
	var screen_size = get_viewport_rect().size
	if global_position.y > screen_size.y:
		if global_position.x in range(0, screen_size.x):
			print("MISSED")
			detonation()
			GameManager.lives -= danger_level
			print(GameManager.lives)

# DETONATION
#	emits signal with firecracker information
func detonation():
	print("KABOOM")
	boom.emit(danger_level, candy_tax, detonation_type)
	queue_free()
