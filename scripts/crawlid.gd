extends Node2D
var dir: float = 20

var attack_damage = 10
var knockback_force = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	half_second()
	pass # Replace with function body.

func half_second():
	await get_tree().create_timer(0.5).timeout
	if(%RayCast2DLeft.is_colliding() or %RayCast2DRight.is_colliding()):
		dir = dir*-1
	half_second()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += dir * delta


func _on_hitbox_area_entered(area: HitboxComponent) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage == attack_damage
		attack.knockback_force == knockback_force
		attack.attack_position == global_position
		area.damage(attack)
