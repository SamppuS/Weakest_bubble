extends Node2D
var dir: float = 20

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
	%Area2D.position.x += dir * delta
