extends CanvasLayer

# INT VARIABLES
var life_counter: int = 4

# FLOAT VARIABLES
var time_elapsed: float = 0

# ONREADY VARIABLES
#	counter and time taken
@onready var candy_counter = $GameStats/CandyCounter
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
	var drop = get_tree().get_first_node_in_group("Candy")
	drop.update_candy_count.connect(update_candy)

# PROCESS
#	updates time
#	minutes:seconds:milliseconds
func _process(delta: float) -> void:
	time_elapsed += delta
	
	var minutes := int(time_elapsed) / 60
	var seconds := int(time_elapsed) % 60
	var msec := int(fmod(time_elapsed, 1.0) * 100)
	
	time_label.text = "TIME: %02d:%02d:%02d" % [minutes, seconds, msec]

# UPDATE LIFE
#	decreases life counter by 1
func update_life():
	life_counter -= 1
	print("LIFE COUNTER: " + str(life_counter))
	
	for i in lives.size():
		lives[i].set_alive()
		if i > life_counter:
			lives[i].set_dead()

# LOST LIFE
#	calls lose life
#	sets stun timer
func _on_lost_life(stun: float):
	print("LOST LIFE RECEIVED")
	update_life()
	GameManager.hurt = true
	
	await get_tree().create_timer(stun).timeout
	
	GameManager.hurt = false

# UPDATE CANDY
# 	increments candy points
func update_candy(candy_count: int):
	candy_counter.text = "CANDY: " + str(candy_count)
