extends Spatial

onready var audio = $AudioStreamPlayer3D
onready var sprite = $Sprite3D
var got_piece = false

func _ready():
	Signals.connect("got_piece", self, "_got_piece")
	
func _got_piece():
	sprite.texture = load("res://Assets/Imgs/piece"+String(Globals.pieces + 1)+".png")

func _on_Area_body_entered(body):
	if body.is_in_group("player") and !got_piece:
		got_piece = true
		visible = false
		play_sound()
		
func play_sound():
	audio.play()
	yield(get_tree().create_timer(2),"timeout")
	Globals.get_piece()
	queue_free()
