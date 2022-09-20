extends Node

onready var correct = $SfxCorrect
onready var wrong = $SfxWrong
onready var tween_in = $TweenIn
onready var tween_out = $TweenOut
var transition_duration = 1.00
var transition_type = 1
var currently_playing = ""
var music_keys = ['DefaultMusic', 'FinishMusic']
var fade_out_original_db_value = 0

func change_music(new_music, with_fade = true, force_play = false):
	if (currently_playing != new_music) || force_play:
		if with_fade:
			fade_out_all_musics()
			fade_in(get_node(new_music))
		else:
			stop_all_musics()
			get_node(new_music).play()
		currently_playing = new_music
		
func play_correct_effect():
	correct.play()
	
func play_wrong_effect():
	wrong.play()
	
func play_effect(node_name):
	var sfx_player = get_node(node_name)
	sfx_player.play()
	
func stop_effect(node_name):
	var sfx_player = get_node(node_name)
	fade_out(sfx_player)
		
func stop_all_musics():
	for music in music_keys:
		var musicNode = get_node(music)
		if musicNode.playing:
			musicNode.stop()
		
func fade_out_all_musics():
	for music in music_keys:
		var musicNode = get_node(music)
		if musicNode.playing:
			fade_out(musicNode)

func fade_in(stream_player):
	var initial_db_value = stream_player.volume_db
	stream_player.volume_db = -80
	stream_player.play()
	tween_in.interpolate_property(stream_player, "volume_db", -80, initial_db_value, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_in.start()

func fade_out(stream_player):
	fade_out_original_db_value = stream_player.volume_db
	tween_out.interpolate_property(stream_player, "volume_db", stream_player.volume_db, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()

func _on_TweenOut_tween_completed(object, _key):
	object.stop()
	object.volume_db = fade_out_original_db_value

func _on_TweenIn_tween_completed(object, _key):
	object.play()
