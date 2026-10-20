extends Control

var text_size: int = 0
var padding: int = 35

var is_hovering: bool = false

var tween: Tween

@export var button_text: String

@onready var default_label = $Background/DefaultLabel
@onready var hover_label = $Background/HoverLabel
@onready var button_background = $Background

signal button_pressed

func _ready() -> void:
	default_label.text = button_text
	hover_label.text = button_text
	hover_label.hide()
	
	button_background.custom_minimum_size.x = hover_label.get_minimum_size().x + padding
	button_background.size.x = button_background.custom_minimum_size.x
	
	button_background.get_material().set_shader_parameter("progress", 0.0)
	button_background.get_material().set_shader_parameter("reverse", false)
	
	$Button.mouse_entered.connect(enter_hover)
	$Button.mouse_exited.connect(exit_hover)
	$Button.pressed.connect(on_button_pressed)

func update_labels():
	if is_hovering:
		default_label.hide()
		hover_label.show()
	else:
		default_label.show()
		hover_label.hide()

func enter_hover():
	is_hovering = true
	update_labels()
	$Hover.play()
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(button_background.material, "shader_parameter/progress", 1.0, 0.15)

func exit_hover():
	is_hovering = false
	update_labels()
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(button_background.material, "shader_parameter/progress", 0.0, 0.15)

func on_button_pressed():
	button_pressed.emit()
