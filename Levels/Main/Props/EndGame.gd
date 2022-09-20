extends Area

func _on_EndGame_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("lock_door")
