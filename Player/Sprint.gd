extends Node


export var controller_path := NodePath("../")
onready var controller: MovementController = get_node(controller_path)

export var head_path := NodePath("../Head")
onready var cam: Camera = get_node(head_path).cam

export var sprint_speed := 16
export var fov_multiplier := 1.05
onready var normal_speed: int = controller.speed
onready var normal_fov: float = cam.fov

onready var walking_sound = $Walking
onready var sprinting_sound = $Sprinting

func _physics_process(delta: float) -> void:
	if can_sprint():
		play_sprint()
		controller.speed = sprint_speed
		cam.set_fov(lerp(cam.fov, normal_fov * fov_multiplier, delta * 8))
	else:
		play_walk()
		controller.speed = normal_speed
		cam.set_fov(lerp(cam.fov, normal_fov, delta * 8))

func can_sprint() -> bool:
	return (controller.is_on_floor() and Input.is_action_pressed("sprint") 
			and controller.input_axis.x >= 0.5)
			
func play_sprint():
	check_still()
	if !sprinting_sound.is_playing() and !is_still():
		walking_sound.stop()
		sprinting_sound.play()
	
func play_walk():
	check_still()
	if !walking_sound.is_playing() and !is_still():
		sprinting_sound.stop()
		walking_sound.play()

func check_still():
	if is_still():
		sprinting_sound.stop()
		walking_sound.stop()
	
func is_still():
	return controller.input_axis.x == 0 and controller.input_axis.y == 0
