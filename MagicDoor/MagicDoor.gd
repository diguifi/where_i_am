extends MeshInstance

onready var camera = get_viewport().get_camera()
onready var animation = get_parent().get_node("AnimationPlayer")
var can_open := false
var opened = false

func _ready():
	Signals.connect("final_place_reached", self, "_final_place_reached")

func _input(event: InputEvent):
	if event.is_action_pressed("action") and can_open and !animation.is_playing():
		if !opened:
			animation.play("door_open")
			opened = true
		else:
			animation.play("door_close")
			opened = false

func _process(_delta):
	var camera_pos = camera.global_transform.origin
	var door_pos = global_transform.origin
	if door_pos.distance_to(camera_pos) <= 2.5:
		can_open = true
	else:
		can_open = false
		
func _final_place_reached():
	if opened:
		animation.play("door_close")
		opened = false
