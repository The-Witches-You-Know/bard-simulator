extends Node

@export var locationTextures: Array[Texture2D] = []
@export var locationMusic: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/TheOrcStoryDayOne.dialogue"), "start"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func loadPlace(idx):
	$LocationTextureRect.texture = locationTextures[idx]
	Audio_Player.setMusic(locationMusic[idx])
