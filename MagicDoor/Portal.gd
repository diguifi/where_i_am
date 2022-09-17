extends Sprite3D

func _ready():
	Signals.connect("final_place_reached", self, "_final_place_reached")
	
func _final_place_reached():
	queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		TriggerManager.reset()
		get_tree().reload_current_scene()
