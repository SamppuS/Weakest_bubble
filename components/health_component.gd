extends Node2D
class_name HealthComponent

signal player_death


@export var Max_Health := 10
var health : float

func ready():
	health = Max_Health
func damage(attack:Attack):
	health -= attack.attack_damage
	if health <= 0:
		if get_parent().is_in_group("Player"):
			%AudioStreamPlayer2D.play()
			emit_signal("player_death")
		else:
			get_parent().queue_free()
func die_player():
	%AudioStreamPlayer2D.play()
	emit_signal("player_death")
