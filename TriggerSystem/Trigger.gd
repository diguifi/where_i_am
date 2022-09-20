extends MeshInstance

onready var area = $Area/CollisionShape
export(Globals.event) var trigger_event = Globals.event.MUSIC
export(Globals.place) var trigger_place = Globals.place.NONE
export var music = ""

func _ready():
	Signals.connect("clear_triggers_of_place", self, "_check_clear_trigger")
	
func _check_clear_trigger(arg):
	if trigger_event == Globals.event.PLACE and trigger_place == arg:
		queue_free()

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		Signals.emit_signal("trigger_event", trigger_event, trigger_place, music)
