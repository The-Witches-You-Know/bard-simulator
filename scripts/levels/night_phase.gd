extends Node

class_name NightPhaseView

@export var locationTextures: Array[Texture2D] = []
@export var locationMusic: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	GameStateHolder.nightPhaseView = self
	Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/TheOrcStoryDayOne.dialogue"), "start"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func loadPlace(idx):
	$LocationTextureRect.texture = locationTextures[idx]
	Audio_Player.playMusic(locationMusic[idx])
	create_tween().tween_property($BlackoutTextureRect, "modulate", Color(1.0,1.0,1.0,0.0), 1.0)
	
func unloadPlace():
	Audio_Player.muteMusic()
	create_tween().tween_property($BlackoutTextureRect, "modulate", Color(1.0,1.0,1.0,1.0), 1.0)
	
func onNightPhaseOver():
	unloadPlace()
	create_tween().tween_callback(func():
		Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/Epilogue.dialogue"), "start"))
	).set_delay(2.0)
	
func onEpilogueOver():	
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.END_GAME)
	
