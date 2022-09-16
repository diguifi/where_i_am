extends Node

func _ready():
	Signals.connect("trigger_event", self, "_trigger_received")

func _trigger_received(event):
	print(event)
