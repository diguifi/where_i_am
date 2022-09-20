extends Spatial

export var sfx_name = ""

func _on_PropSoundManager_body_entered(body):
	if body.is_in_group("player"):
		MusicManager.play_effect(sfx_name)

func _on_PropSoundManager_body_exited(body):
	if body.is_in_group("player"):
		MusicManager.stop_effect(sfx_name)
