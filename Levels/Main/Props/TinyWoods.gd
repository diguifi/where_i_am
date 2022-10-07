extends Spatial

onready var camera = get_viewport().get_camera()
export var never_invisible = false

func _physics_process(delta):
	var camera_pos = camera.global_transform.origin
	var woods_pos = global_transform.origin
	if woods_pos.distance_to(camera_pos) <= 40:
		visible = true
	else:
		if !never_invisible:
			visible = false
		elif woods_pos.distance_to(camera_pos) > 46:
			visible = false
