extends Node

enum event { MUSIC, PLACE }
enum place { NONE, SLIDE, CART, CHAIR }
var end = 1
var pieces = 0
var total_pieces = 5
var world_saturation = 1
var env_node

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(0.1))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear2db(0.5))
	
func _physics_process(delta):
	if end == 2 and world_saturation < 1.8:
		world_saturation += delta
		env_node.adjustment_saturation = world_saturation
		env_node.fog_depth_end += delta * 6
		env_node.dof_blur_far_distance += delta * 8

func get_piece():
	pieces += 1
	if pieces >= total_pieces:
		end = 2
		env_node = get_node('/root/Game/Lighting/WorldEnvironment').get_environment()
