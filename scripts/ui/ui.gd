extends CanvasLayer
class_name interface

@export var HUD : PackedScene
@export var Menu : PackedScene

var current : Control

func _ready():
	$Paused.visible = false

# Switch layer so pause appears in front of dialogue
# Probably not the best way but hey it works
func switch_ui_state(state):

	if current != null:
		current.queue_free()

	match state:
		global.MENU:
			$Paused.visible = false
			current = Menu.instantiate()
			add_child(current)
			layer = 99
		global.GAME_WORLD:
			$Paused.visible = false
			current = HUD.instantiate()
			add_child(current)
			layer = 99
		global.PAUSED:
			layer = 101
			$Paused.visible = true

func set_time(time):
	var hud = current as HUDInterface
	hud.set_time_of_day(time)
	
func set_day(day):
	var hud = current as HUDInterface
	hud.set_day(day)
