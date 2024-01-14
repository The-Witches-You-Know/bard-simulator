extends Area2D

var in_range = false

func _process(_delta):
	if in_range:
		if Input.is_action_just_released("interact"):
			# Should we use the dialogue system for confirmation stuff... probably
			var game_world = get_node("/root/Main/GameWorld") as GameWorld
			game_world.pass_time()
			game_world.switch_level("map")

func _on_body_entered(_body):
	in_range = true

func _on_body_exited(_body):
	in_range = false
