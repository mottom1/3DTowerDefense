extends Button
export var Level: PackedScene

func _on_button_pressed():
	get_tree().change_scene_to(Level)
