extends Node2D

@export var flylid : PackedScene
@export var player : Node2D

var flylids := []
var flyer_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Time.get_ticks_msec() > flyer_timer:
		var enemy = flylid.instantiate()
		add_child(enemy)
		enemy.player = player
		enemy.position = player.center + Vector2.UP * 1000 + Vector2.RIGHT * randf_range(-20, 20)
		
		flyer_timer = Time.get_ticks_msec() + randi_range(5000, 12000)
	
