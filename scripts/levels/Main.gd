extends Node
class_name Manager

@export var game_world_scene : PackedScene

var ui : interface
var current : Node
var current_state = global.MENU
var last_state = global.MENU

func _ready():
	ui = $UI as interface
	ui.switch_ui_state(global.MENU)

func switch_state(state):

	last_state = current_state
	current_state = state

	match state:
		global.MENU:
			if last_state == global.PAUSED: # Was the game world
				ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "transition_menu_callback"), "fade_in")
			if last_state == global.CREDITS:
				ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "transition_menu_callback"), "fade_in")
		global.GAME_WORLD:
			if last_state == global.PAUSED:
				ui.switch_ui_state(global.GAME_WORLD)
			else:
				ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "transition_gameworld_callback"), "fade_in")
		global.PAUSED:
			ui.switch_ui_state(state)
		global.CREDITS:
			ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "transition_for_basic_ui"), "fade_in")
		global.END_GAME:
			ui.LoadingSceneRef.play_transition("fade_out", Callable(self, "transition_for_basic_ui"), "fade_in")
			ui.EndGameRef.load_endgame()

func switch_to_last_state():
	switch_state(last_state)

func transition_gameworld_callback():
	ui.switch_ui_state(current_state)
	current = game_world_scene.instantiate()
	add_child(current)

func transition_menu_callback():
	ui.switch_ui_state(current_state)
	if current != null:
		current.queue_free()

func transition_for_basic_ui():
	ui.switch_ui_state(current_state)
