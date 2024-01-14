extends Node
class_name Manager

@export var game_world_scene : PackedScene

var ui : interface
var current : Node
var current_state = global.MENU

func _ready():
	ui = $UI as interface
	switch_state(global.MENU)

func switch_state(state):
	
	if current != null:
		current.queue_free()
	
	ui.switch_ui_state(state)
	
	current_state = state
	
	match state:
		global.MENU:
			pass
		global.GAME_WORLD:
			current = game_world_scene.instantiate()
			add_child(current)
		global.PAUSED:
			pass
