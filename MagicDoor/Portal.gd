extends Sprite3D

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
