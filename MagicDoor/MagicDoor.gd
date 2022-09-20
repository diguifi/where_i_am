extends MeshInstance

onready var  open_sfx = $DoorOpen
onready var  close_sfx = $DoorClose
onready var camera = get_viewport().get_camera()
onready var animation = get_parent().get_node("AnimationPlayer")
var can_open := false
var opened = false
var door_locked = false

func _ready():
	Signals.connect("final_place_reached", self, "_final_place_reached")
	Signals.connect("lock_door", self, "_lock_door")

func _input(event: InputEvent):
	if !door_locked:
		if event.is_action_pressed("action") and can_open and !animation.is_playing():
			toggle_door()

func _process(_delta):
	var camera_pos = camera.global_transform.origin
	var door_pos = global_transform.origin
	if door_pos.distance_to(camera_pos) <= 2.5:
		can_open = true
	else:
		can_open = false
		
func toggle_door():
	if !opened:
		open_door()
	else:
		close_door()
		
func open_door():
	if !opened:
		animation.play("door_open")
		open_sfx.play()
		opened = true
		
func close_door():
	if opened:
		animation.play("door_close")
		close_sfx.play()
		opened = false
		
func _final_place_reached():
	close_door()
		
func _lock_door():
	door_locked = true
	close_door()
