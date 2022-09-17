extends MeshInstance

onready var area = $Area/CollisionShape
export(Globals.event) var trigger_event = Globals.event.GENERIC
export(Globals.place) var trigger_place = Globals.place.PLACE1

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("trigger_event", trigger_event, trigger_place)
		queue_free()
