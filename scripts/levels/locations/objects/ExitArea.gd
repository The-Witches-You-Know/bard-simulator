extends Area2D

class_name ExitArea

var in_range = false

var can_leave = false

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta):
	if in_range:
		if Input.is_action_just_released("interact") and Audio_Player.balloonReference == null:
			if can_leave:
				Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/confirm_return.dialogue"), "start"))
			else:
				Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/cannot_return.dialogue"), "start"))

func _on_body_entered(body):
	if (body.name == "player"):
		in_range = true

func _on_body_exited(body):
	if (body.name == "player"):
		in_range = false
