extends Node2D
class_name HealthComponent


@export var Max_Health := 10
var health : float

func ready():
	health = Max_Health

func damage(attack:Attack):
	health -= attack.attack_damage
	if health <= 0:
		get_parent.queue_free()
