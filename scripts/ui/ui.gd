extends CanvasLayer
class_name interface

@export var HUD : PackedScene
@export var Menu : PackedScene

@onready var LoadingSceneRef = $LoadingScene as LoadingScene
@onready var EndGameRef = $EndGame as EndGame
@onready var CreditsRef = $Credits as Credits

func switch_ui_state(state):

	match state:
		global.MENU:
			layer = 1
			$Paused.visible = false
			$HUD.visible = false
			$Menu.visible = true
			$Credits.visible = false
			$EndGame.visible = false
		global.GAME_WORLD:
			layer = 1
			$Paused.visible = false
			$HUD.visible = true
			$Menu.visible = false
			$Credits.visible = false
			$EndGame.visible = false
		global.PAUSED:
			layer = 101
			$Paused.visible = true
			$HUD.visible = false
			$Menu.visible = false
			$Credits.visible = false
			$EndGame.visible = false
		global.CREDITS:
			layer = 1
			$Paused.visible = false
			$HUD.visible = false
			$Menu.visible = false
			$Credits.visible = true
			$EndGame.visible = false
		global.END_GAME:
			layer = 1
			$Paused.visible = false
			$HUD.visible = false
			$Menu.visible = false
			$Credits.visible = false
			$EndGame.visible = true

func set_time(time):
	var hud = $HUD as HUDInterface
	hud.set_time_of_day(time)
	
func set_day(day):
	var hud = $HUD as HUDInterface
	hud.set_day(day)
