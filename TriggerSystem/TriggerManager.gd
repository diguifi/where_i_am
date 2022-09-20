extends Node

var correct_order = [Globals.place.SLIDE, Globals.place.CART, Globals.place.CHAIR]
var last_place = Globals.place.NONE

func _ready():
	Signals.connect("trigger_event", self, "_trigger_received")

func _trigger_received(event, place, music):
	match (event):
		Globals.event.MUSIC:
			MusicManager.change_music(music)
		Globals.event.PLACE:
			if is_in_correct_order(place):
				if is_final_place(place):
					Signals.emit_signal("final_place_reached")
					MusicManager.play_correct_effect()
					MusicManager.change_music('FinishMusic')
				else:
					MusicManager.play_correct_effect()
				Signals.emit_signal("clear_triggers_of_place", place)
			else:
				MusicManager.play_wrong_effect()

func is_in_correct_order(place):
	if last_place == Globals.place.NONE and place == correct_order[0]:
		last_place = correct_order[0]
		return true
		
	if last_place != Globals.place.NONE:
		var place_index = correct_order.find(place)
		if correct_order[place_index - 1] == last_place:
			last_place = place
			return true
	return false
	
func is_final_place(place):
	var last_place = correct_order[-1]
	return place == last_place

func reset():
	last_place = Globals.place.NONE
