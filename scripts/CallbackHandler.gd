extends Node

signal load_location

var location_to_load = ""

func LoadLocation():
	var game_world = get_node("/root/Main/GameWorld") as GameWorld
	game_world.switch_level(location_to_load)
	
func LoadMap():
	var game_world = get_node("/root/Main/GameWorld") as GameWorld
	game_world.pass_time()
	if (GameStateHolder.timeOfDay == 3):
		game_world.switch_level("night_phase")
	else:
		game_world.switch_level("map")
		
