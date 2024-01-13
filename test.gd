extends Node


# Called when the node enters the scene tree for the first time.
func _ready():	
	create_tween().tween_callback(func():
		Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/test.dialogue"), "start"))
		).set_delay(0.4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
