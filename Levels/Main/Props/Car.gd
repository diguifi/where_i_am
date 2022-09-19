extends Spatial

onready var door_slam = $DoorSlam
onready var engine = $Engine
onready var accelerate = $Accelerate

var can_move = false
var speed = 6

func _ready():
	Signals.connect("start_game", self, "_start")
	engine.play()
	
func _physics_process(delta):
	if can_move:
		transform.origin.x -= speed * delta
	if transform.origin.x < -100:
		queue_free()

func _start():
	door_slam.play()

func _on_DoorSlam_finished():
	accelerate.play()
	can_move = true
