extends Control

# INT VARIABLES
var text_size: int = 0
var padding: int = 35

# BOOLEAN VARIABLES
var is_hovering: bool = false

# TWEEN VARIABLES
var tween: Tween

# EXPORT VARIABLES
@export var button_text: String

# ONREADY VARIABLES
@onready var default_label = $Background/DefaultLabel
@onready var hover_label = $Background/HoverLabel
@onready var button_background = $Background

# SIGNALS
signal button_pressed

# READY
#	sets labels to custom text
#	sets minimum horizontal size for hover background and button
#	connects button signals to respective functions
func _ready() -> void:
	# button not hovering -> show default / hide hover
	default_label.text = button_text
	hover_label.text = button_text
	hover_label.hide()
	
	# set minimum size.x
	button_background.custom_minimum_size.x = hover_label.get_minimum_size().x + padding
	button_background.size.x = button_background.custom_minimum_size.x
	$Button.size.x = button_background.custom_minimum_size.x
	
	# set shader- progress:0.0 | reverse = false
	button_background.get_material().set_shader_parameter("progress", 0.0)
	button_background.get_material().set_shader_parameter("reverse", false)
	
	# connect button signals
	$Button.mouse_entered.connect(enter_hover)
	$Button.mouse_exited.connect(exit_hover)
	$Button.pressed.connect(on_button_pressed)

# UPDATE LABELS
#	shows/hides labels if hovering / not hovering
func update_labels():
	if is_hovering:
		default_label.hide()
		hover_label.show()
	else:
		default_label.show()
		hover_label.hide()

# ENTER HOVER
#	calls update_labels if mouse hovering
#	plays hover noise
#	tween animation on hover
func enter_hover():
	is_hovering = true
	update_labels()
	$Hover.play()
	
	if tween:
		tween.kill()
	
	# sets shader parameter to 1.0 after 0.5 seconds
	tween = create_tween()
	tween.tween_property(button_background.material, "shader_parameter/progress", 1.0, 0.15)

# EXIT HOVER
#	calls update_labels if mouse not hovering
#	tween animation on hover exit
func exit_hover():
	is_hovering = false
	update_labels()
	
	if tween:
		tween.kill()
	
	# sets shader parameter to 0.0 after 0.5 seconds
	tween = create_tween()
	tween.tween_property(button_background.material, "shader_parameter/progress", 0.0, 0.15)

# ON BUTTON PRESSED
#	emit signal button_pressed
func on_button_pressed():
	$Pressed.play()
	button_pressed.emit()
