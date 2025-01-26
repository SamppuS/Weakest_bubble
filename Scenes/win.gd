extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(4).timeout
	%PanelContainer.visible = false
	$PanelContainer2/VBoxContainer/HBoxContainer/Label.text = "Time: "+Adsgw.time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
