extends Node2D

@export var flylid : PackedScene
@export var player : Node2D
var win_count = 0
var flylids := []
var flyer_timer = 0
var in_spawner := false
var timer = 0
var start_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if win_count < 2:
		timer = Time.get_ticks_msec() - start_time
		var minutes = int(timer / 60000)
		var seconds = int((timer % 60000) / 1000)
		var milliseconds = int(timer % 1000)
		$CanvasLayer/Label.text = "%02d:%02d.%03d" % [minutes, seconds, milliseconds]
	
	if Time.get_ticks_msec() > flyer_timer and in_spawner:
		var enemy = flylid.instantiate()
		add_child(enemy)
		enemy.player = player
		enemy.position = player.center + Vector2.UP * 1000 + Vector2.RIGHT * randf_range(-20, 20)
		
		flyer_timer = Time.get_ticks_msec() + randi_range(8000, 16000)
	
	


func _on_spawn_area_area_entered(area: Area2D) -> void:
	if area.get_parent().get_groups().size() > 0:
		in_spawner = true


func _on_spawn_area_area_exited(area: Area2D) -> void:
	if area.get_parent().get_groups().size() > 0:
		in_spawner = false
func win():
	win_count += 1
	if(win_count>=2):
			print("win")
			player.ascend()
