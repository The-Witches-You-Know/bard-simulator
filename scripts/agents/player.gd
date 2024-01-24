extends CharacterBody2D

class_name PlayerBody

const SPEED = 600.0
var topColliderOffset: int = 30
var collisionDirection: Vector2 = Vector2(0,0)

var speaker: ISpeaker = null
var paused = false

func _ready():
	# add to entity group if you want these to be paused will require the below
	# two functions probably move into inheritance instead
	add_to_group("entity")

func pause_entity():
	paused = true

func unpause_entity():
	paused = false

func _physics_process(_delta):

	if paused:
		return

	var inputX = Input.get_axis("character_left", "character_right")
	var inputY = Input.get_axis ("character_up" , "character_down")
	var input_direction = Vector2(inputX, inputY)
	velocity = input_direction.normalized() * SPEED

	if inputY == -1:
		$AnimatedSprite2D.play("walk_up")
		$AnimatedSprite2D.flip_h = false
		Audio_Player.playSFX()
	elif inputY == 1:
		$AnimatedSprite2D.play("walk_down")
		$AnimatedSprite2D.flip_h = false
		Audio_Player.playSFX()
	elif inputX == 1:
		$AnimatedSprite2D.play("walk_right")
		$AnimatedSprite2D.flip_h = false
		Audio_Player.playSFX()
	elif inputX == -1:
		$AnimatedSprite2D.play("walk_right")
		$AnimatedSprite2D.flip_h = true
		Audio_Player.playSFX()
	elif velocity == Vector2(0, 0):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("idle")
	
	# if collider is in the direction where the player is going, dont move and slide
	if (velocity == Vector2(0, 0) and collisionDirection != Vector2(0,0)):
		velocity = collisionDirection * -1
	if (velocity != collisionDirection):
		move_and_slide()
	if get_slide_collision_count() > 0:
		collisionDirection = get_slide_collision(0).get_normal() * -1
	else:
		collisionDirection = Vector2(0,0)
	if Input.is_action_just_pressed("interact") and speaker != null:
		speaker.onInteract()
		
func setCameraLimit(boundaryMin: Vector2, boundaryMax: Vector2):
	$Camera2D.limit_top = boundaryMin.y - topColliderOffset
	$Camera2D.limit_left = boundaryMin.x
	$Camera2D.limit_bottom = boundaryMax.y
	$Camera2D.limit_right = boundaryMax.x


func _on_area_2d_area_entered(area):
	var parent = area.get_parent()
	if parent is ISpeaker:
		speaker = parent
		parent.onAreaEntered()
	elif parent is GroupSpeakerPart:
		speaker = parent.parent
		parent.onAreaEntered()


func _on_area_2d_area_exited(area):
	var parent = area.get_parent()	
	if (parent is ISpeaker and parent == speaker) or (parent is GroupSpeakerPart and parent.parent == speaker):
		parent.onAreaExited()
		speaker = null
