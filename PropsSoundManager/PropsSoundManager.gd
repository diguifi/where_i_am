extends Spatial

onready var sfx_player = $Sfx
export(AudioStream) var stream

func _ready():
	sfx_player.stream = stream

func _on_PropSoundManager_body_entered(body):
	if body.is_in_group("player"):
		MusicManager.fade_in_3d(sfx_player)

func _on_PropSoundManager_body_exited(body):
	if body.is_in_group("player"):
		MusicManager.fade_out_3d(sfx_player, 3)
