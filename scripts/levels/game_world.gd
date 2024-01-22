extends Node
class_name GameWorld

@export var dict : Dictionary
var ui: interface

enum time_of_day { MORNING = 0, DAYTIME = 1, EVENING = 2, NIGHT = 3 }

var time : time_of_day = time_of_day.MORNING
var day = 1
var current : Node2D

func _ready():
	ui = get_node("/root/Main/UI") as interface
	switch_level(GameStateHolder.currentLevel)
	time = GameStateHolder.timeOfDay
	day = GameStateHolder.currentDay
	ui.set_day(day)
	ui.set_time(time)

func switch_level(level):
	if current != null:
		current.queue_free()

	if level in dict:
		current = load(dict[level]).instantiate()
		add_child(current)
		GameStateHolder.currentLevel = level

func pass_time():	
	if time == 3:
		time = time_of_day.MORNING
		day += 1
		GameStateHolder.setCurrentDay(day)
		ui.set_day(day)
	else:
		time += 1
		
	GameStateHolder.setTimeOfDay(time)
	ui.set_time(time)
	GameStateHolder.currentLevelNode = null
