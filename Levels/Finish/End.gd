extends Control

onready var label = $Label
onready var label2 = $Label2
onready var label3 = $Label3
export var waiting_time = 2
var time = 0

func _process(delta):
	if time >= waiting_time:
		label.visible = true
		label2.visible = true
		label3.visible = true
	else:
		time += delta

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match Input.get_mouse_mode():
			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
