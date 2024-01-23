extends CanvasLayer
class_name interface

@export var HUD : PackedScene
@export var Menu : PackedScene

@onready var LoadingSceneRef = $LoadingScene as LoadingScene

var current : Control

func _ready():
	$Paused.visible = false

func switch_ui_state(state):

	if current != null:
		current.queue_free()

	match state:
		global.MENU:
			$Paused.visible = false
			current = Menu.instantiate()
			add_child(current)
		global.GAME_WORLD:
			$Paused.visible = false
			current = HUD.instantiate()
			add_child(current)
		global.PAUSED:
			$Paused.visible = true

func set_time(time):
	var hud = current as HUDInterface
	hud.set_time_of_day(time)
	
func set_day(day):
	var hud = current as HUDInterface
	hud.set_day(day)
