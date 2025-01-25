extends Node2D
class_name Player

@export var force_function: Curve

@onready var player = $Player
@onready var sword = get_node("Bubble_Sword")
@onready var bubblebody = $Bubblebody

const radius = 15

var center := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sword_data = find_angle()
	
	

	if sign(sword_data[2]) != sign(sword.angular_velocity):
		sword.angular_velocity = 0
	#print(sword_data[2])
	if force_function:
		sword.apply_torque_impulse(-1500 * force_function.sample(abs(sword_data[2]) / 180) * sign(sword_data[2]))
	
	#$StaticBody2D.global_position = get_global_mouse_position()
	
	center = bubble_center()
	#print(cent)
	$StaticBody2D.global_position = center
	
	

func find_angle():
	var mouse_pos = get_global_mouse_position()
	var player_pos = bubble_center() #player.global_position
	var vector = (mouse_pos - player_pos).normalized()
	var angle = vector.angle() - 3.14/2
	
	var player_to_mouse = rad_to_deg(player_pos.direction_to(get_global_mouse_position()).angle())
	var player_to_sword = rad_to_deg(player_pos.direction_to(sword.global_position).angle())
	
	var angle_diff = player_to_sword - player_to_mouse
	if angle_diff > 180:
		angle_diff = angle_diff - 360
	elif angle_diff < -180:
		angle_diff = angle_diff + 360
	
	#print(angle_diff)
	

	return [vector, angle, angle_diff]

func bubble_center():
	var bones = bubblebody.get_children()
	var total_pos : Vector2
	var boneniness := 0
	for i in bones:
		if i is RigidBody2D:
			boneniness += 1
			total_pos += i.global_position
	total_pos /= boneniness
	
	return total_pos
