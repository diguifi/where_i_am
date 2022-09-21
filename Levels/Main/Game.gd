extends Spatial

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)
	start_game()

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match Input.get_mouse_mode():
			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func start_game():
	yield(get_tree().create_timer(0.5),"timeout")
	Signals.emit_signal("start_game")
