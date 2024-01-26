@tool
extends ISpeaker

class_name GroupSpeaker

@export var actionName: String = ""
@export var dialogues: Array[DialogueResource] = []
@export var speakerParts: Array[GroupSpeakerPart] = []
@export var indicesForChecking: Array[int] = []

var isTalking = false
var selectedAnimName = null
var alternateAnimationPlaying = false
var currentSpeakerPart: GroupSpeakerPart
	
func _ready():
	if not Engine.is_editor_hint():		
		var currentDayPart = (GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay
		visible = dialogues[currentDayPart] != null
		hasBeenSpokenTo = indicesForChecking[currentDayPart] == -1 or GameStateHolder.PeopleSpokenTo[currentDayPart][indicesForChecking[currentDayPart]]
		for part in speakerParts:
			part.setCollisionDisabled(!visible)

func onInteract():
	if(visible and not hasBeenSpokenTo):
		GameStateHolder.setCurrentSpeaker(self)
		onConversationStarted()
		var balloon = DialogueManager.show_example_dialogue_balloon(dialogues[(GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay], "start")
		Audio_Player.setBalloonReference(balloon)
	
func talk(nameInBalloon: String):
	if (nameInBalloon != null):
		if (currentSpeakerPart == null or currentSpeakerPart.speakerName != nameInBalloon):
			idle(true)
			var speakerIdx = speakerParts.map(func(x): return x.speakerName).find(nameInBalloon)
			if (speakerIdx == -1):
				return
			currentSpeakerPart = speakerParts[speakerIdx]
		currentSpeakerPart.talk(nameInBalloon)
	
func idle(resetAnimName: bool):
	if (currentSpeakerPart != null):
		currentSpeakerPart.idle(resetAnimName)
	
func play(animationName):
	if (currentSpeakerPart != null):
		currentSpeakerPart.play(animationName)
	
func onConversationStarted():
	for part in speakerParts:
		part.onConversationStarted()
	
func onConversationFinished():
	hasBeenSpokenTo = true
	for part in speakerParts:
		part.onConversationFinished()
	
	

