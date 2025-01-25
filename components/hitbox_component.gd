extends Node2D

@export var health_component : HealthComponent

func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
