extends Spatial

onready var camera = get_viewport().get_camera()

func _physics_process(delta):
	var camera_pos = camera.global_transform.origin
	var woods_pos = global_transform.origin
	if woods_pos.distance_to(camera_pos) <= 40:
		visible = true
	else:
		visible = false
