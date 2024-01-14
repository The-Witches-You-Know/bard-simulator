extends Node
class_name Manager

@export var game_world_scene : PackedScene

var ui : interface
var current : Node
var current_state = global.MENU
var last_state = global.MENU

func _ready():
	ui = $UI as interface
	switch_state(global.MENU)

# Improve this should cleanly instantiate when needed
func switch_state(state):
	
	last_state = current_state
	ui.switch_ui_state(state)
	current_state = state
	
	match state:
		global.MENU:
			if current != null && last_state != global.MENU:
				current.queue_free()
			pass
		global.GAME_WORLD:
			if last_state != global.PAUSED:
				current = game_world_scene.instantiate()
				add_child(current)
			else:
				for agent in get_tree().get_nodes_in_group("entity"):
					agent.unpause_entity()
				pass
		global.PAUSED:
			for agent in get_tree().get_nodes_in_group("entity"):
				agent.pause_entity()
			pass

func switch_to_last_state():
	switch_state(last_state)
