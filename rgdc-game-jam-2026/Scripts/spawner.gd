extends Node2D

# EXPORT VARIABLES
@export_category("Candy")
@export var candy_scene: PackedScene
@export var candy_timer: float

@export_category("Firecrackers")
@export var firecrackers_scenes: Array[PackedScene]
@export var firecracker_timer: float

# INT VARIABLES
var random_firecracker: int
var random_scene: int
var current_wave: int = 1

# FLOAT VARIABLES
var candy_spawn_timer: float
var firecracker_spawn_timer: float

# BOOLEAN VARIABLES
var spawning: bool = false

# READY
#	spawns candy or firecracker
func _ready() -> void:
	spawn_candy_firecracker()

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
	get_tree().current_scene.add_child(candy)
	candy.global_position = global_position
	print("CANDY SPAWNED")

# SPAWN FIRECRACKER
#	spawns firecracker scene
func spawn_firecracker():
	var firecracker: Node2D = firecrackers_scenes[random_firecracker].instantiate()
	get_tree().current_scene.add_child(firecracker)
	firecracker.global_position = global_position
	print("FIRECRACKER SPAWNED")
