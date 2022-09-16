extends MeshInstance

onready var area = $Area/CollisionShape
export var trigger_event = ""

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("trigger_event", trigger_event)
		queue_free()
