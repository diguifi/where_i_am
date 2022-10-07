extends Sprite3D

onready var collision = $Area/CollisionShape

func _ready():
	Signals.connect("final_place_reached", self, "_final_place_reached")
	Signals.connect("got_all_pieces", self, "_got_all_pieces")
	if Globals.suicide_attempts >= Globals.max_suicide_attempts:
		collision.disabled = true
	
func _final_place_reached():
	queue_free()
	
func _got_all_pieces():
	collision.disabled = false

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		Globals.entered_portal()
		get_tree().reload_current_scene()
