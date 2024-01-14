extends CharacterBody2D

class_name Speaker

@export var speakerName: String = ""
@export var dialogue: DialogueResource
@onready var talkPanel: Panel = $TalkPanel
@onready var talkPanelLabel: Label = $TalkPanel/Label

func onAreaEntered():
	talkPanel.visible = true
func onAreaExited():
	talkPanel.visible = false

func _ready():
	talkPanelLabel.text = "["+InputMap.action_get_events("interact")[0].as_text().substr(0, 1)+"] Talk"


func onInteract():
	var balloon = DialogueManager.show_example_dialogue_balloon(dialogue, "start")
	Audio_Player.setBalloonReference(balloon)

