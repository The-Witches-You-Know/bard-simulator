extends Area2D

var in_range = false

func _process(_delta):
	if in_range:
		if Input.is_action_just_released("interact"):
			create_tween().tween_callback(func():
				Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/confirm_return.dialogue"), "start"))
				).set_delay(0.4)

func _on_body_entered(_body):
	in_range = true

func _on_body_exited(_body):
	in_range = false
