extends CharacterBody2D

class_name PlayerBody

const SPEED = 300.0

var speaker: Speaker = null

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
	if Input.is_action_just_pressed("interact") and speaker != null:
		speaker.onInteract()
		
func setCameraLimit(boundaryMin: Vector2, boundaryMax: Vector2):
	$Camera2D.limit_top = boundaryMin.y
	$Camera2D.limit_left = boundaryMin.x
	$Camera2D.limit_bottom = boundaryMax.y
	$Camera2D.limit_right = boundaryMax.x


func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is Speaker:
		speaker = parent
		speaker.onAreaEntered()


func _on_area_2d_area_exited(area):
	var parent = area.get_parent()
	if parent == speaker:
		speaker.onAreaExited()
		speaker = null
