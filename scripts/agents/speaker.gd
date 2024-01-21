@tool
extends StaticBody2D

class_name Speaker

@export var speakerName: String = ""
@export var actionName: String = ""
@export var collisionDisabled: bool = true : set = setCollisionDisabled
@export var dialogue: DialogueResource
@export var animationFrames: SpriteFrames = null : set = setSpriteFrames
@export var collider: Shape2D = null : set = setCollisionShape

@onready var talkPanel: Panel = $TalkPanel
@onready var talkPanelLabel: Label = $TalkPanel/Label
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
var isTalking = false
var selectedAnimName = null

func setSpriteFrames(newFrames: SpriteFrames):
	animationFrames = newFrames
	if (newFrames != null and animatedSprite != null):
		animatedSprite.sprite_frames = animationFrames

func setCollisionDisabled(newValue: bool):
	collisionDisabled = newValue
	$CollisionShape2D.disabled = collisionDisabled

func setCollisionShape(newCollider: Shape2D):
	collider = newCollider
	$CollisionShape2D.shape = newCollider
	$Area2D/CollisionShape2D.shape = newCollider

func onAreaEntered():
	talkPanel.visible = true	
	if not Engine.is_editor_hint():
		talkPanelLabel.text = "["+InputMap.action_get_events("interact")[0].as_text().substr(0, 1)+"] "+actionName
		
func onAreaExited():
	talkPanel.visible = false
	
func _ready():	
	setSpriteFrames(animationFrames)
	animatedSprite.play("idle")

func onInteract():
	GameStateHolder.setCurrentSpeaker(self)
	var balloon = DialogueManager.show_example_dialogue_balloon(dialogue, "start")
	Audio_Player.setBalloonReference(balloon)
	
func talk(speakerName: String):
	if !isTalking:
		animatedSprite.stop()
		isTalking = true
		if selectedAnimName not in animationFrames.animations:
			selectedAnimName = animationFrames.animations.filter(func(x): return "talk" in x.name).pick_random().name
		animatedSprite.play(selectedAnimName)
	
func idle():
	animatedSprite.stop()
	isTalking = false
	selectedAnimName = null
	animatedSprite.play("idle")
	

