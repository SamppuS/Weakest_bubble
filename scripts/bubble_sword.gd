extends RigidBody2D

var attack_damage := 10
var knockback_force := 10
var attack_position : Vector2

var knockdir = 1

@onready var bubble = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_hitbox_area_entered(area: HitboxComponent) -> void:
	if area is HitboxComponent:
		knockdir = 1
		var attack = Attack.new()
		attack.attack_damage == attack_damage
		attack.knockback_force == knockback_force
		attack.attack_position == global_position
		area.damage(attack)
		bubble.recoil(knockback_force * 800)
		#print("recoil RIIIIGHT")


func _on_hitbox_body_entered(body: Node2D) -> void:
	%AudioStreamPlayer2D.play()


func _on_hitbox_2_area_entered(area: HitboxComponent) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage == attack_damage
		attack.knockback_force == knockback_force
		attack.attack_position == global_position
		area.damage(attack)
		bubble.recoil(knockback_force * -800)
		#print("recoil LEEEFT")
	
	


func _on_hitbox_3_area_entered(area: HitboxComponent) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage == attack_damage
		attack.knockback_force == knockback_force
		attack.attack_position == global_position
		area.damage(attack)
		bubble.recoil(knockback_force * -800, "epic time!")
