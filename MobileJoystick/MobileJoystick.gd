extends CanvasLayer

signal mobile_input
signal mobile_rotation

onready var button_movement = $TouchScreenButton
onready var button_rotation = $TouchScreenButton2

func _ready():
	if !Globals.is_mobile:
		queue_free()

func _input(event):
	check_movement(event)
	check_rotation(event)
	
func check_movement(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if button_movement.is_pressed() and event.position.x < 180:
			var move_vector = calculate_move_vector(event.position)
			emit_signal("mobile_input", move_vector)
		else:
			emit_signal("mobile_input", Vector2(0,0))
			
func check_rotation(event):
	if event is InputEventScreenDrag:
		if button_rotation.is_pressed() and event.position.x > 180:
			emit_signal("mobile_rotation", event.relative)

func calculate_move_vector(event_position):
	var texture_center = button_movement.position + Vector2(38.5,38.5)
	return (event_position - texture_center).normalized()
