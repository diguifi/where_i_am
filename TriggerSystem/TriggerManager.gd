extends Node

var correct_order = [Globals.place.PLACE1, Globals.place.PLACE2]
var last_place = Globals.place.NONE
var already_wrong = false

func _ready():
	Signals.connect("trigger_event", self, "_trigger_received")

func _trigger_received(event, place, music):
	match (event):
		Globals.event.MUSIC:
			MusicManager.change_music(music)
		Globals.event.PLACE:
			if is_in_correct_order(place) and !already_wrong:
				if is_final_place(place):
					Signals.emit_signal("final_place_reached")
					MusicManager.play_correct_effect()
					MusicManager.change_music('FinishMusic')
				else:
					Signals.emit_signal("clear_triggers_of_place", place)
					MusicManager.play_correct_effect()
			else:
				MusicManager.play_wrong_effect()
				already_wrong = true

func is_in_correct_order(place):
	if last_place == Globals.place.NONE and place == Globals.place.PLACE1:
		last_place = Globals.place.PLACE1
		return true
		
	if last_place != Globals.place.NONE:
		var place_index = correct_order.find(place)
		return correct_order[place_index - 1] == last_place
	return false
	
func is_final_place(place):
	var last_place = correct_order[-1]
	return place == last_place

func reset():
	last_place = Globals.place.NONE
	already_wrong = false
