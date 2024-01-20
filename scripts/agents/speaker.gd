@tool
extends StaticBody2D

class_name Speaker

@export var speakerName: String = ""
@export var actionName: String = ""
@export var collisionDisabled: bool = true : set = setCollisionDisabled
@export var dialogue: DialogueResource
@export var defaultSprite: Texture2D = null : set = setTexture
@export var collider: Shape2D = null : set = setCollisionShape

@onready var talkPanel: Panel = $TalkPanel
@onready var talkPanelLabel: Label = $TalkPanel/Label

func setTexture(newTexture: Texture2D):
	defaultSprite = newTexture
	$Sprite2D.texture = defaultSprite

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

func onInteract():
	var balloon = DialogueManager.show_example_dialogue_balloon(dialogue, "start")
	Audio_Player.setBalloonReference(balloon)

