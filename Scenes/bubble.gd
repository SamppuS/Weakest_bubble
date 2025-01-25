extends Node2D

@export var force_function: Curve

@onready var player = $Player
@onready var sword = $BubbleSword

const radius = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Camera2D.make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sword_data = find_angle()
	
	#sword.rotation = Vector2()
	#print(sword_data)
	#var target_position = player.position + sword_data[0] * radius
	#var target_rotation = sword_data[1]
	#sword.position = player.position + sword_data[0] * radius
	
	#sword.apply_torque_impulse(150)
	#print()
	#sword.apply_impulse(sword_data[0] , sword.position)
	
	#if abs(sword_data[2]) > 10:
		#sword.apply_torque_impulse(50 * sign(sword_data[2]))
	if sign(sword_data[2]) != sign(sword.angular_velocity):
		sword.angular_velocity = 0
	print(sword_data[2])
	if force_function:
		sword.apply_torque_impulse(-1500 * force_function.sample(abs(sword_data[2]) / 180) * sign(sword_data[2]))
	
	$StaticBody2D.global_position = get_global_mouse_position()
	

func find_angle():
	var mouse_pos = get_global_mouse_position()
	var player_pos = player.global_position
	var vector = (mouse_pos - player_pos).normalized()
	var angle = vector.angle() - 3.14/2
	
	var player_to_mouse = rad_to_deg(player.global_position.direction_to(get_global_mouse_position()).angle())
	var player_to_sword = rad_to_deg(player.global_position.direction_to(sword.global_position).angle())
	
	var angle_diff = player_to_sword - player_to_mouse
	if angle_diff > 180:
		angle_diff = angle_diff - 360
	elif angle_diff < -180:
		angle_diff = angle_diff + 360
	
	#print(angle_diff)
	

	return [vector, angle, angle_diff]
