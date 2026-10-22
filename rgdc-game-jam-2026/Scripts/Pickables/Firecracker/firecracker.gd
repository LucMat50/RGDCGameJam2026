class_name Firecracker
extends RigidBody2D

# INT VARIABLES
var random_firecracker: int

# VECTOR2 VARIABLES
var last_position: Vector2

# AUDIO STREAM PLAYER
var boom_sound = AudioStreamPlayer.new()

# PACKED SCENE
var detonation_type: PackedScene

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
@export var detonation_sound: String
@export var detonation_timer: Timer

@export_category("Position")
@export var last_position_notifier: VisibleOnScreenNotifier2D 

# CONSTANT VARIABLES
const SPARK_PARTICLES = preload("res://Scenes/VFX/spark.tscn")

# READY
# starts detonation timer
func _ready() -> void:
	spark_particles()
	detonation_timer.start(detonation_time)
	detonation_timer.timeout.connect(detonation)
	
	last_position_notifier.screen_exited.connect(detonation)
	
	boom_sound.stream = load(detonation_sound)
	GameManager.add_child(boom_sound)

func _process(_delta: float) -> void:
	if last_position_notifier.is_on_screen():
		last_position = global_position

# SPARK PARTICLES
#	instantiate and set spark at beginning of the wick
func spark_particles():
	var spark = SPARK_PARTICLES.instantiate()
	spark.position = spark_offset
	self.add_child(spark)

# DETONATION
#	emits signal with firecracker information
func detonation():
	
	var screen_size = get_viewport_rect().size
	
	GameEvents.boom.emit(danger_level, candy_tax)
	
	if get_parent().is_held or last_position.y > screen_size.y:
		print("SIGNAL LOST LIFE EMITTED")
		get_parent().is_held = false
		GameManager.hold = false
		GameManager.candy_points -= candy_tax
		GameEvents.lost_life.emit(stun_time)

	boom_sound.play()
	explosion_particles()
	queue_free()

# EXPLOSION PARTICLES
#	adds explosion to firecracker/firework
func explosion_particles():
	var explosion = detonation_type.instantiate()
	
	for child in explosion.get_children():
		if child is CPUParticles2D or GPUParticles2D:
			child.restart()
	
	explosion.position = last_position
	GameManager.add_child(explosion)
