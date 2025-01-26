extends AnimationPlayer

func _ready():
	animation_finished.connect(_on_animation_finished)
	$Camera2D.zoom = Vector2(0.6, 0.6)
	play("animation1")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"animation1":
			$Camera2D.zoom = Vector2(1, 1)
			play("animation2")
		"animation2":
			get_tree().change_scene_to_file("res://Scenes/World.tscn")
