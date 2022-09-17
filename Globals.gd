extends Node

enum event { MUSIC, PLACE }
enum place { NONE, PLACE1, PLACE2 }

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(0.1))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear2db(0.5))
