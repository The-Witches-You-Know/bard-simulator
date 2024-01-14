extends Node

signal load_location

var location_to_load = "town"

func LoadLocation():
	var game_world = get_node("/root/Main/GameWorld") as GameWorld
	game_world.switch_level(location_to_load)
