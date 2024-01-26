@tool
extends Node2D

class_name GroupSpeakerPart

@export var speakerName : String = ""
@export var animationFrames: SpriteFrames = null : set = setSpriteFrames
@export var collider: Shape2D = null : set = setCollisionShape
@export var animatedSpriteTransformPosition: Vector2 = Vector2(0,0) : set = setAnimatedSpriteTransformPosition
@export var colliderTransformPosition: Vector2 = Vector2(0,0) : set = setColliderTransformPosition
@export var collisionDisabled: bool = true : set = setCollisionDisabled
@export var speakerSound: AudioStream

@export var parent: GroupSpeaker

@onready var talkPanel: Panel = $TalkPanel
@onready var talkPanelLabel: Label = $TalkPanel/Label
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var isTalking = false
var selectedAnimName = null
var alternateAnimationPlaying = false
var shouldShowTalkPanel: bool = false
var conversationFinished = false

func setCollisionDisabled(newValue: bool):
	collisionDisabled = newValue
	$CollisionShape2D.disabled = collisionDisabled
	$Area2D/CollisionShape2D.disabled = collisionDisabled

func setSpriteFrames(newFrames: SpriteFrames):
	animationFrames = newFrames
	if (newFrames != null):
		$AnimatedSprite2D.sprite_frames = animationFrames

func setAnimatedSpriteTransformPosition(newValue: Vector2):
	animatedSpriteTransformPosition = newValue
	$AnimatedSprite2D.position = animatedSpriteTransformPosition

func setCollisionShape(newCollider: Shape2D):
	collider = newCollider
	$CollisionShape2D.shape = newCollider
	$Area2D/CollisionShape2D.shape = newCollider

func setColliderTransformPosition(newValue: Vector2):
	colliderTransformPosition = newValue
	$CollisionShape2D.position = colliderTransformPosition
	$Area2D/CollisionShape2D.position = colliderTransformPosition

func onAreaEntered():
	if not parent.hasBeenSpokenTo:
		talkPanel.visible = true	
		if not Engine.is_editor_hint():
			talkPanelLabel.text = "["+InputMap.action_get_events("interact")[0].as_text().substr(0, 1)+"] "+parent.actionName
		
func onAreaExited():
	talkPanel.visible = false

func _ready():
	if not Engine.is_editor_hint():
		visible = parent.visible		
		setCollisionDisabled(!visible)
		setSpriteFrames(animationFrames)


func onInteract():
	shouldShowTalkPanel = true
	parent.onInteract()
	
func talk(nameInBalloon: String):
	if !isTalking and !conversationFinished:
		Audio_Player.setSpeakerSound(speakerSound)
		animatedSprite.stop()
		isTalking = true
		if selectedAnimName not in animationFrames.animations.map(func(x): return x.name):
			selectedAnimName = animationFrames.animations.filter(func(x): return "talk" in x.name).pick_random().name
		animatedSprite.play(selectedAnimName)
	
func idle(resetAnimName: bool):
	isTalking = false
	Audio_Player.setSpeaker("")
	if resetAnimName:
		selectedAnimName = null
	if(!alternateAnimationPlaying):
		animatedSprite.stop()
		if "silent" in animationFrames.animations.map(func(x): return x.name):
			animatedSprite.play("silent")
		else:
			animatedSprite.play("idle")
	
func play(animationName):	
	animatedSprite.stop()
	selectedAnimName = animationName
	animatedSprite.play(selectedAnimName)
	alternateAnimationPlaying = true
	
func onConversationStarted():
	talkPanel.visible = false
	
func onConversationFinished():
	talkPanel.visible = shouldShowTalkPanel
	shouldShowTalkPanel = false
	Audio_Player.setSpeaker("")
	animatedSprite.play("idle")
	conversationFinished = true
	
	

