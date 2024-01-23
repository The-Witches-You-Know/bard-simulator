extends Control

func _ready():
	$AnimationPlayer.play("reveal_skip_button")
	# 1. Start credit animation
	pass # Replace with function body.

func _process(delta):
	# 2. If player presses down speed up credits
	# 2. up to reverse credits
	pass

func _on_skip_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.MENU)
