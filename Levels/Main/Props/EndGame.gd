extends Area

func _on_EndGame_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("lock_door")
		finish_game()
		
func finish_game():
	yield(get_tree().create_timer(5),"timeout")
	get_tree().change_scene("res://Levels/Finish/End"+ String(Globals.end) +".tscn")
