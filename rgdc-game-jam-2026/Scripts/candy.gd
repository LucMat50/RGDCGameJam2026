class_name Candy
extends Node2D

# EXPORT VARIABLES
@export var candy_type: Texture2D

# ONREADY VARIABLES
@onready var mouse_pin = $PinJoint2D
@onready var fake_body = $PinJoint2D/CharacterBody2D
@onready var rigid_body = $RigidBody2D

# BOOLEAN VARIABLES
var is_held: bool = false

func _ready():
	add_to_group("candy")
	rigid_body.input_pickable = true
	mouse_pin.node_a = ""
	mouse_pin.node_b = ""

func _on_rigid_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and not is_held:
			is_held = true
			fake_body.global_position = event.position
			mouse_pin.global_position = event.position
			
			mouse_pin.node_a = fake_body.get_path()
			mouse_pin.node_b = rigid_body.get_path()

func _input(event: InputEvent) -> void:			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.is_pressed() and is_held:
			is_held = false
			mouse_pin.node_a = ""
			mouse_pin.node_b = ""

func _physics_process(_delta: float) -> void:
	if is_held:
		fake_body.global_position = get_global_mouse_position()
