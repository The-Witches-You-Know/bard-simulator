@tool
extends StaticBody2D

class_name NonInteractable

var collisionDisabled: bool = true : set = setCollisionDisabled
@export var visibleAtTimes: Array[bool] = []
@export var spriteTexture: Texture2D = null : set = setTexture
@export var collider: Shape2D = null : set = setCollisionShape
@export var spriteTransformPosition: Vector2 = Vector2(0,0) : set = setSpriteTransformPosition
@export var colliderTransformPosition: Vector2 = Vector2(0,0) : set = setColliderTransformPosition

@onready var sprite: Sprite2D = $Sprite2D

var isTalking = false
var selectedAnimName = null
var alternateAnimationPlaying = false

func setCollisionDisabled(newValue: bool):
	collisionDisabled = newValue
	$CollisionShape2D.disabled = collisionDisabled

func setTexture(texture2D: Texture2D):
	spriteTexture = texture2D
	$Sprite2D.texture = spriteTexture

func setSpriteTransformPosition(newValue: Vector2):
	spriteTransformPosition = newValue
	$Sprite2D.position = spriteTransformPosition

func setCollisionShape(newCollider: Shape2D):
	collider = newCollider
	$CollisionShape2D.shape = newCollider
	$Area2D/CollisionShape2D.shape = newCollider

func setColliderTransformPosition(newValue: Vector2):
	colliderTransformPosition = newValue
	$CollisionShape2D.position = colliderTransformPosition
	$Area2D/CollisionShape2D.position = colliderTransformPosition
	
func _ready():
	if not Engine.is_editor_hint():
		visible = visibleAtTimes[(GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay]
		setCollisionDisabled(!visible)
