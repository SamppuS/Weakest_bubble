extends CanvasLayer

var is_paused = false

func _ready() -> void:
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	is_paused = !is_paused
	
	if is_paused:
		show()
		get_tree().paused = true
	else:
		hide()
		get_tree().paused = false


func _on_button_pressed() -> void:
	toggle_pause()


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_quit_to_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
