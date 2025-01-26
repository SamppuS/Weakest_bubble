extends Node2D


@export var force_function: Curve
@onready var player = $Player
@onready var sword = get_node("Bubble_Sword")
@onready var bubblebody = $Bubblebody
@onready var bubblesword = $Bubble_Sword
@onready var camera = $StaticBody2D/Camera2D


const radius = 15

var center := Vector2.ZERO
var recoiling := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Health_Component_Player.player_death.connect(_on_player_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sword_data = find_angle()
	
	

	if sign(sword_data[2]) != sign(sword.angular_velocity) and not recoiling:
		sword.angular_velocity = 0
	if force_function:
		var force = -1500
		if recoiling:
			force /= 5
		sword.apply_torque_impulse(force * force_function.sample(abs(sword_data[2]) / 180) * sign(sword_data[2]))
	
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

func recoil(power: float, mode: String = ""):
	if not recoiling:
		recoiling = true
		
		if mode != "":
			pass
			#sword.apply_impulse(find_angle()[0] * power / 7000, center)
		else: 
			sword.apply_torque_impulse(power)
		
		await get_tree().create_timer(0.2).timeout
		recoiling = false
		




func _on_player_death():
	get_tree().root.add_child(bubblesword)
	get_child(2).visible = false
	get_child(3).get_child(1).visible = false
	#get_tree().root.add_child(camera)
	#queue_free()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area.get_child(1) is CollisionPolygon2D:
		print("d")
		$Health_Component_Player.health = -1000
