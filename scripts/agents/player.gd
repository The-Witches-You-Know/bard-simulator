extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):

	var inputX = Input.get_axis("character_left", "character_right")
	var inputY = Input.get_axis ("character_up" , "character_down")
	var input_direction = Vector2(inputX, inputY)
	velocity = input_direction.normalized() * SPEED

	if inputY == -1:
		#$AnimationPlayer.play("up", 1, 4)
		pass
	elif inputY == 1:
		#$AnimationPlayer.play("down", 1, 4)
		pass
	elif inputX == 1:
		#$AnimationPlayer.play("right", 1, 4)
		pass
	elif inputX == -1:
		#$AnimationPlayer.play("left", 1, 4)
		pass
	elif velocity == Vector2(0, 0):
		#$AnimationPlayer.stop()
		pass

	move_and_slide()
