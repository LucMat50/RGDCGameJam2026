class_name Pickable
extends Node2D

# EXPORT VARIABLES
@export var type: String

# ONREADY VARIABLES
@onready var rigid_body = $RigidBody2D

# BOOLEAN VARIABLES
var is_held: bool = false

# NODE VARIABLES	
var mouse_pin: PinJoint2D
var fake_body: StaticBody2D

# set RigidBody to pickable
#	CollisionShape2D can detect mouse
func _ready():
	add_to_group("pickable")
	rigid_body.input_pickable = true

func _on_rigid_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and not is_held:
			is_held = true
			drag()
			fake_body.global_position = event.position
			mouse_pin.node_b = rigid_body.get_path()

func _input(event: InputEvent) -> void:			
	if event is InputEventMouseMotion and is_held:
		fake_body.position = event.position
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.is_pressed() and is_held:
			is_held = false
			fake_body.queue_free()

func _physics_process(_delta: float) -> void:
	if is_held:
		fake_body.global_position = get_global_mouse_position()

func drag():
	# Create new joint and character body for new drag position
	fake_body = StaticBody2D.new()
	mouse_pin = PinJoint2D.new()
	
	#pinjoint2d set up
	#mouse_pin.angular_limit_enabled = true
	#mouse_pin.angular_limit_lower = deg_to_rad(45)
	#mouse_pin.angular_limit_upper = deg_to_rad(-45)
	
	
	# add characterbody to pinjoint 
	fake_body.add_child(mouse_pin)
	
	# add pinjoint to tree
	owner.add_child(fake_body)
	
	# set node_a to characterbody
	mouse_pin.node_a = fake_body.get_path()
