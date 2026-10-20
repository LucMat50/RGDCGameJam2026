extends CanvasLayer

@onready var transition_type = $ColorRect/AnimationPlayer
@onready var transition_canvas = $ColorRect

var type_dictionary : Dictionary ={
	1: "fade",
	2: "slide"
}

signal in_transition_done(target_scene: String)

# READY
#	Hides transition on the first frame
func _ready() -> void:
	transition_canvas.hide()

# EMIT IN TRANSITION DONE
#	emits in_transition_done
func emit_in_transition_done():
	in_transition_done.emit()

# CHANGE SCENE
#	choice of transition to target scene 
func change_scene(target_scene: String, type: String, color:Color):
	transition_canvas.color = color
	transition_canvas.show()
	
	match type:
		"fade":
			transition_type.play("fade_in")
			await in_transition_done
			get_tree().change_scene_to_file(target_scene)
			transition_type.play("fade_out")
		"slide":
			transition_type.play("slide_in")
			await in_transition_done
			get_tree().change_scene_to_file(target_scene)
			transition_type.play("slide_out")
