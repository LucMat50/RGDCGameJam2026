extends Control

var tween: Tween

@export var button_text: String

@onready var default_label = $DefaultLabel
@onready var hover_label = $HoverLabel
@onready var button_background = $TextureRect

func _ready() -> void:
	default_label.text = button_text
	hover_label.text = button_text
	
	button_background.get_material().set_shader_parameter("progress", 1.0)
	button_background.get_material().set_shader_parameter("reverse", false)
	
	$Button.mouse_entered.connect(enter_hover)
	$Button.mouse_exited.connect(exit_hover)

func enter_hover():
	pass

func exit_hover():
	pass
