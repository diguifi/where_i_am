extends Spatial

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		MusicManager.play_kids_effect()

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		MusicManager.stop_kids_effect()
