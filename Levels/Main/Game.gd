extends Spatial

func _ready():
	toggle_mouse_capture(true)
	set_process_input(true)
	start_game()

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match Input.get_mouse_mode():
			Input.MOUSE_MODE_CAPTURED:
				toggle_mouse_capture(false)
			Input.MOUSE_MODE_VISIBLE:
				toggle_mouse_capture(true)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				toggle_mouse_capture(true)
				
func toggle_mouse_capture(is_captured):
	if !Globals.is_mobile:
		if is_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func start_game():
	yield(get_tree().create_timer(0.5),"timeout")
	Signals.emit_signal("start_game")
