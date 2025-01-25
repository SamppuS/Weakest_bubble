extends RigidBody2D

var attack_damage := 10
var knockback_force := 10
var attack_position : Vector2

@onready var bubble = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_hitbox_area_entered(area: HitboxComponent) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage == attack_damage
		attack.knockback_force == knockback_force
		attack.attack_position == global_position
		area.damage(attack)
