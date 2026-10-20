extends Control

var text_size: int = 0
var margin: int = 10

var is_hovering: bool = false

var tween: Tween

@export var button_text: String

@onready var default_label = $DefaultLabel
@onready var hover_label = $HoverLabel
@onready var button_background = $TextureRect

signal button_pressed

func _ready() -> void:
	default_label.text = button_text
	hover_label.text = button_text
	hover_label.hide()
	
	text_size = default_label.label_settings.font.get_string_size(default_label.text).x
	print(text_size)
	default_label.size.x = text_size + (margin * 30)
	$Button.size.x = text_size + (margin * 30)
	button_background.size.x = text_size + (margin * 30)
	
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
