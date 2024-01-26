extends Area2D

class_name ExitArea

var in_range = false

var can_leave = false

func _ready():
	$AnimationPlayer.play("idle")

func _process(_delta):
	if in_range and self.visible:
		if Input.is_action_just_released("interact"):
			if can_leave:
				create_tween().tween_callback(func():
					Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/confirm_return.dialogue"), "start"))
					).set_delay(0.4)
			else:
				create_tween().tween_callback(func():
					Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/cannot_return.dialogue"), "start"))
					).set_delay(0.4)

func _on_body_entered(body):
	if (body.name == "player"):
		in_range = true

func _on_body_exited(body):
	if (body.name == "player"):
		in_range = false
