@tool
extends ISpeaker

class_name GroupSpeaker


@export var speakerName: String = ""
@export var actionName: String = ""
@export var dialogues: Array[DialogueResource] = []
@export var speakerParts: Array[GroupSpeakerPart] = []

var isTalking = false
var selectedAnimName = null
var alternateAnimationPlaying = false

	
func _ready():
	if not Engine.is_editor_hint():
		visible = (dialogues[(GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay] != null)

func onInteract():
	if(visible):
		GameStateHolder.setCurrentSpeaker(self)
		onConversationStarted()
		var balloon = DialogueManager.show_example_dialogue_balloon(dialogues[(GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay], "start")
		Audio_Player.setBalloonReference(balloon)
	
func talk(nameInBalloon: String):
	pass
	
func idle(resetAnimName: bool):
	pass
	
func play(animationName):	
	pass
	
func onConversationStarted():
	pass
	
func onConversationFinished():
	pass
	
	

