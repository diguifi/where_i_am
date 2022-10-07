extends Spatial

export(NodePath) var cam_path := NodePath("Camera")
onready var cam: Camera = get_node(cam_path)
onready var fog = $Fog

export var mouse_sensitivity := 2.0
export var y_limit := 90.0
var mouse_axis := Vector2()
var rot := Vector3()

func _ready():
	if get_node('/root/Game/Lighting/WorldEnvironment').get_environment().fog_enabled:
		fog.visible = true
	if Globals.is_mobile:
		mouse_sensitivity = mouse_sensitivity / 200
	else:
		mouse_sensitivity = mouse_sensitivity / 1000
	y_limit = deg2rad(y_limit)

func _input(event: InputEvent):
	if !Globals.is_mobile:
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			mouse_axis = event.relative
			camera_rotation()

func camera_rotation():
	rot.y -= mouse_axis.x * mouse_sensitivity
	rot.x = clamp(rot.x - mouse_axis.y * mouse_sensitivity, -y_limit, y_limit)
	
	get_owner().rotation.y = rot.y
	rotation.x = rot.x


func _on_MobileJoystick_mobile_rotation(relative):
	mouse_axis = relative
	if mouse_axis.x < 30 and mouse_axis.x > -30:
		camera_rotation()
