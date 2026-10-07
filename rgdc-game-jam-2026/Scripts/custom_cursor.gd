extends Sprite2D

# ARRAY VARIABLES
var hold_frames: Array = [
	preload("res://Assets/Hand/hand_hold_1.png"),
	preload("res://Assets/Hand/hand_hold_2.png")
]

var hurt_frames: Array = [
	preload("res://Assets/Hand/hand_hurt_1.png"),
	preload("res://Assets/Hand/hand_hurt_2.png")
]

var idle_frames: Array = [
	preload("res://Assets/Hand/hand_idle_1.png"),
	preload("res://Assets/Hand/hand_idle_2.png")
]

# ANIMATION VARIABLES
var current_frame: int = 0
var anim_timer: float = 0

# EXPORT VARIABLES
@export var fps: float = 0.3							#time per frame
@export var click_offset: Vector2 = Vector2.ZERO		#click origin

#func _ready() -> void:
#	set_cursor_scale(0.5)

# PROCESS
func _process(delta: float) -> void:
	anim_timer += delta
	idle_anim()

# PHYSICS PROCESS
func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()

# IDLE ANIMATION
func idle_anim():
	if anim_timer >= fps:
		anim_timer = 0
		current_frame = (current_frame + 1) % idle_frames.size()
		
		Input.set_custom_mouse_cursor(
			idle_frames[current_frame],
			Input.CURSOR_ARROW,
			click_offset
		)

# HOLD ANIMATION
func hold_anim():
	if anim_timer >= fps:
		anim_timer = 0
		current_frame = (current_frame + 1) % hold_frames.size()
		
		Input.set_custom_mouse_cursor(
			hold_frames[current_frame],
			Input.CURSOR_ARROW,
			click_offset
		)

# HURT/STUN ANIMATION
func hurt_anim():
	if anim_timer >= fps:
		anim_timer = 0
		current_frame = (current_frame + 1) % hurt_frames.size()
		
		Input.set_custom_mouse_cursor(
			hurt_frames[current_frame],
			Input.CURSOR_ARROW,
			click_offset
		)
