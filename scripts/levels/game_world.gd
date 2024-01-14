extends Node
class_name GameWorld

@export var dict : Dictionary

enum time_of_day { MORNING = 0, DAYTIME = 1, EVENING = 2, NIGHT = 3 }

var time : time_of_day = time_of_day.MORNING
var day = 1
var current : Node2D

func _ready():
	switch_level("map")

func _process(_delta):
	if Input.is_action_just_released("pause"):
		var main = get_node("/root/Main") as Manager
		main.switch_state(global.PAUSED)

func switch_level(level):
	if current != null:
		current.queue_free()

	if level in dict:
		current = load(dict[level]).instantiate()
		add_child(current)

func pass_time():
	var ui = get_node("/root/Main/UI") as interface
	
	if time == 3:
		time = time_of_day.MORNING
		day += 1
		ui.set_day(day)
	else:
		time += 1

	ui.set_time(time)
