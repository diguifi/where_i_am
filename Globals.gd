extends Node

enum event { MUSIC, PLACE }
enum place { NONE, SLIDE, CART, CHAIR }
var end = 1
var pieces = 0
var total_pieces = 5
var world_saturation = 1
var env_node
var initial_saturation = 1
var initial_fog = 1
var initial_blur = 1
var has_set_initials = false
var suicide_attempts = 0
var max_suicide_attempts = 5
var is_mobile = false

func _ready():
	is_mobile = JavaScript.eval("/Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile/.test(navigator.userAgent)", true)
	if (!is_mobile):
		is_mobile = false
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(0.1))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear2db(0.5))
	
func _physics_process(delta):
	if end == 2 and !has_set_initials:
		has_set_initials = true
		initial_saturation = env_node.adjustment_saturation
		initial_fog = env_node.fog_depth_end
		initial_blur = env_node.dof_blur_far_distance
	if end == 2 and world_saturation < 1.8:
		world_saturation += delta
		env_node.adjustment_saturation = world_saturation
		env_node.fog_depth_end += delta * 6
		env_node.dof_blur_far_distance += delta * 8
		
func set_end(number):
	if number == 1:
		if end == 3:
			end = 1
			suicide_attempts = 0
	if number == 2:
		Signals.emit_signal("got_all_pieces")
		end = 2
	if number == 3:
		end = 3

func get_piece():
	pieces += 1
	if pieces >= total_pieces:
		set_end(2)
		env_node = get_node('/root/Game/Lighting/WorldEnvironment').get_environment()
		MusicManager.play_pieces_effect()
	else:
		Signals.emit_signal("got_piece")
		
func entered_portal():
	TriggerManager.reset()
	reset()
	suicide_attempts += 1
	if suicide_attempts >= max_suicide_attempts:
		set_end(3)

func reset():
	end = 1
	pieces = 0
	total_pieces = 5
	world_saturation = 1
	if env_node:
		env_node.adjustment_saturation = initial_saturation
		env_node.fog_depth_end = initial_fog
		env_node.dof_blur_far_distance = initial_blur
