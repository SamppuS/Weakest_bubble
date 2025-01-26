extends CharacterBody2D

const speed = 60

@onready var agent := $NavigationAgent2D
@export var player : Node2D

@export var bob_speed = 2.0  # Adjust for faster/slower movement
@export var bob_amount = 0.02  # Adjust for larger/smaller movement

@onready var sprites = $sprites.get_children()
var time_offsets = []

func _ready():
	sprites.remove_at(6)
	for sprite in sprites:
		time_offsets.append(randf() * 10.0)  # Random starting offset

func _physics_process(delta: float) -> void:
	var dir = to_local(agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
	#print("man I wanna go to ", velocity, agent.target_position)

func _process(delta):
	for i in sprites.size():
		var sprite = sprites[i]
		var offset = sin((Time.get_ticks_msec() / 1000.0 + time_offsets[i]) * bob_speed) * bob_amount
		sprite.position.y = sprite.position.y + offset


func generate_path():
	agent.target_position = player.center

func _on_timer_timeout() -> void:
	generate_path()
