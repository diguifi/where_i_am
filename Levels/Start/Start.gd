extends Control

onready var label = $Label
var selected_time = 3
var passed_time = 0

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("action") or event.is_action_pressed("jump"):
		get_tree().change_scene("res://Levels/Main/Game.tscn")

func _process(delta):
	passed_time += delta
	if passed_time >= selected_time and label.visible:
		label.visible = false
		flick_label()
		
func flick_label():
	var time = (randi()%2+1)/10.0
	yield(get_tree().create_timer(time),"timeout")
	selected_time = randf()*1.5
	passed_time = 0
	label.visible = true
