extends CharacterBody2D

const speed = 20

@onready var agent := $NavigationAgent2D

@export var player : Node2D

func _physics_process(delta: float) -> void:
	var dir = to_local(agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	print("man I wanna go to ", velocity, agent.target_position)
	
func generate_path():
	agent.target_position = player.center

func _on_timer_timeout() -> void:
	generate_path()
