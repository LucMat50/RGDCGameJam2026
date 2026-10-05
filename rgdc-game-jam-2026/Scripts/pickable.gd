class_name Pickable
extends Node2D

# EXPORT VARIABLES
@export var candy: bool
@export var firecracker: bool

# ONREADY VARIABLES
@onready var rigid_body = $RigidBody2D

# BOOLEAN VARIABLES
var is_held: bool = false

# NODE VARIABLES	
var mouse_pin: PinJoint2D
var fake_body: StaticBody2D
var crinkle = AudioStreamPlayer.new()

# READY
#	Adds to group Pickable
#	Adds to group Candy or Rocket
#	Sets up RigidBody2D
func _ready():
	crinkle.stream = load("res://Sound/Crinkle.MP3")
	add_child(crinkle)
	
	rigid_body.add_to_group("Pickable")
	
	if candy and !firecracker:
		rigid_body.add_to_group("Candy")
	elif firecracker and !candy:
		rigid_body.add_to_group("Firecracker")
	
	rigid_body.input_pickable = true 	#detects mouse
	rigid_body.gravity_scale = 1 		#no gravity/floating
	rigid_body.angular_damp = 2 		#slows down swing
	rigid_body.linear_damp = 0.3 		#movement drag

# ON RIGID BODY INPUT EVENT
#	Sets held to true if mouse pressed
#	Sends mouse position to START DRAG
func _on_rigid_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and not is_held:
			# True when mouse pressed on CollisionShape2D
			is_held = true
			crinkle.play()
			# Set anchor to mouse position
			start_drag(event.position)

# INPUT:
#	Stops drag when mouse is no longer pressed
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.is_pressed() and is_held:
			stop_drag()

# PHYSICS PROCESS:
# 	Follows mouse if pressing down
func _physics_process(_delta: float) -> void:
	if is_held:
		fake_body.global_position = get_global_mouse_position()

# START DRAG:
#	Creates anchor body at mouse position
func start_drag(click_position: Vector2):
	# Create the anchor body
	fake_body = StaticBody2D.new()
	owner.add_child(fake_body)
	
	# Position anchor at mouse position
	fake_body.global_position = click_position
	
	# Create and setup PinJoint2D
	mouse_pin = PinJoint2D.new()
	fake_body.add_child(mouse_pin)
	
	# finetuning for joint feel
	mouse_pin.softness = 0.5 	#slight spring/elastic feel
	mouse_pin.bias = 0.9 		#how fast joint recovers position
	
	# Connect nodes via node path
	mouse_pin.node_a = fake_body.get_path()
	mouse_pin.node_b = rigid_body.get_path()

# STOP DRAG:
#	Sets held to false
#	Deletes created anchor body from START DRAG
func stop_drag():
	is_held = false
	if is_instance_valid(fake_body):
		fake_body.queue_free()
