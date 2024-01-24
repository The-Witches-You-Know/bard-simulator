extends Node
class_name GameWorld

@export var dict : Dictionary
var ui: interface

enum time_of_day { MORNING = 0, DAYTIME = 1, EVENING = 2, NIGHT = 3 }

var time : time_of_day = time_of_day.MORNING
var day = 1
var current : Node2D

var level_to_load
# Hack to avoid two transitions when we load straight from menu to
# the tavern
var skip = true

func _ready():
	ui = get_node("/root/Main/UI") as interface
	switch_level(GameStateHolder.currentLevel)
	time = GameStateHolder.timeOfDay
	day = GameStateHolder.currentDay
	ui.set_day(day)
	ui.set_time(time)

func _process(_delta):
	if Input.is_action_just_released("pause"):
		var main = get_node("/root/Main") as Manager
		if main.current_state == global.PAUSED:
			main.switch_state(global.GAME_WORLD)
		else:
			main.switch_state(global.PAUSED)

func switch_level(level):
	if current != null:
		current.queue_free()

	if level in dict:
		level_to_load = level
		if skip:
			skip = false
			on_scene_load()
		else:	
			ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "on_scene_load"), "fade_in")

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

func on_scene_load():
	current = load(dict[level_to_load]).instantiate()
	add_child(current)
	print(level_to_load)
	GameStateHolder.currentLevel = level_to_load
	
	if level_to_load == "map":
		Audio_Player.setMusic("menu")
	else:
		# After merging come back to this
		if time == time_of_day.NIGHT:
			Audio_Player.setMusic("tavern" + "_" + "night")
		else:
			Audio_Player.setMusic("tavern" + "_" + "day")
