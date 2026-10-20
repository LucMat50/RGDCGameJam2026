extends Button

var tween: Tween

func _ready() -> void:
	get_material().set_shader_parameter("progress", 1.0)
	get_material().set_shader_parameter("reverse", false)
	
	mouse_entered.connect(enter_hover)
	mouse_exited.connect(exit_hover)

func enter_hover():
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(material, "shader_parameter/progress", 1.0, 0.15)

func exit_hover():
	pass
	#if tween:
	#	tween.kill()
	
	#tween = create_tween()
	#tween.tween_property(material, "shader_parameter/progress", 0.0, 1)
