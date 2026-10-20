extends CanvasLayer

# INT VARIABLES
var life_counter: int = 4

# FLOAT VARIABLES
var time_elapsed: float = 0

# ONREADY VARIABLES
#	counter and time taken
@onready var candy_label = $GameStats/CandyCounter
@onready var time_label = $GameStats/TimeElapsed

#	Lives
@onready var life1: Control = $LivesContainer/Life1
@onready var life2: Control = $LivesContainer/Life2
@onready var life3: Control = $LivesContainer/Life3
@onready var life4: Control = $LivesContainer/Life4
@onready var life5: Control = $LivesContainer/Life5
@onready var lives: Array[Control] = []

# READY
#	sets lives 
# 	connects lost life signal to lost life function
func _ready() -> void:
	lives = [life1, life2, life3, life4, life5]
	GameEvents.lost_life.connect(_on_lost_life)

# PROCESS
#	updates time
#	minutes:seconds:milliseconds
func _process(delta: float) -> void:
	candy_label.text = "CANDY: " + str(GameManager.candy_points)
	
	time_elapsed += delta
	GameManager.current_time = time_elapsed
	
	var minutes := int(time_elapsed) / 60
	var seconds := int(time_elapsed) % 60
	var msec := int(fmod(time_elapsed, 1.0) * 100)
	
	time_label.text = "TIME: %02d:%02d:%02d" % [minutes, seconds, msec]

# UPDATE LIFE
#	decreases life counter by 1
func update_life():
	life_counter -= 1
	GameManager.lives -= 1
	print("LIFE COUNTER: " + str(life_counter))
	
	if GameManager.lives > 0:
		for i in lives.size():
			lives[i].set_alive()
			if i > life_counter:
				lives[i].set_dead()
	else:
		GameManager.hurt = false
		GameEvents.game_over.emit()

# LOST LIFE
#	calls lose life
#	sets stun timer
func _on_lost_life(stun: float):
	print("LOST LIFE RECEIVED")
	update_life()
	if GameManager.lives >= 1:
		GameManager.hurt = true
		
		await get_tree().create_timer(stun).timeout
		
		GameManager.hurt = false
