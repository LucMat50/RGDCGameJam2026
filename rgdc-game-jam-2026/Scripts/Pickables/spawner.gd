extends Marker2D

# EXPORT VARIABLES
@export_category("Candy")
@export var candy_scene: PackedScene
@export var candy_timer: float
@export var candy_container: Node2D

@export_category("Firecrackers")
@export var firecrackers_scenes: Array[PackedScene]
@export var firecracker_timer: float
@export var firecracker_container: Node2D

# INT VARIABLES
var random_firecracker: int
var random_scene: int
var current_wave: int = 1
var spawn_time_max: int = 9
var spawn_time_min: int = 3

# FLOAT VARIABLES
var spawn_time: float


# BOOLEAN VARIABLES
var normal_spawning: bool = false
var chaos_spawning: bool = false

# ONREADY VARIABLES
@onready var spawn_timer: Timer = $Timer
@onready var decrease_spawn_timer: Timer = $SpawnDecrease

# READY
#	spawns candy or firecracker
func _ready() -> void:
	set_spawn_time()
	spawn_timer.start(spawn_time)
	spawn_timer.timeout.connect(spawn_candy_firecracker)
	
	decrease_spawn_timer.start(30)
	decrease_spawn_timer.timeout.connect(update_spawn_time)

# SPAWN CANDY / FIRECRACKER
#	calls spawn_candy or spawn_firecracker
func spawn_candy_firecracker():
	random_scene = randi_range(1,2)
	random_firecracker = randi_range(0, 5)
	
	match random_scene:
		1:
			spawn_candy()
		2:
			spawn_firecracker()

# SPAWN CANDY
#	spawns candy scene
func spawn_candy():
	var candy: Node2D = candy_scene.instantiate()
	candy_container.add_child(candy)
	candy.global_position = global_position
	print("CANDY SPAWNED")

# SPAWN FIRECRACKER
#	spawns firecracker scene
func spawn_firecracker():
	var firecracker: Node2D = firecrackers_scenes[random_firecracker].instantiate()
	firecracker_container.add_child(firecracker)
	firecracker.global_position = global_position
	print("FIRECRACKER SPAWNED")

# SET SPAWN TIME
#	throughout wave
func set_spawn_time():
	spawn_time = randf_range(spawn_time_min,spawn_time_max)
	print("SPAWN TIME: " + str(spawn_time))

# UPDATE SPAWN TIME
#	update max spawn time
func update_spawn_time():
	if spawn_time_max > 3:
		spawn_time_max -= 1
		print("SPAWN TIME MAX: " + str(spawn_time_max))
	
	if spawn_time_max < 7 and spawn_time_min > 1:
		spawn_time_min -= 1
	set_spawn_time()

# RAAA CANDY TIME
#	near end of wave 
func raaaa_candy_time():
	spawn_time = randf_range(0.2, 0.5)
