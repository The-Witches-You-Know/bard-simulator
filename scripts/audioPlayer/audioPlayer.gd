extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var ambiencePlayer: AudioStreamPlayer = $AmbiencePlayer
@onready var speechPlayer: AudioStreamPlayer = $SpeechPlayer
@onready var SFXPlayer: AudioStreamPlayer = $SFXPlayer

var isTalking: bool
var balloonReference: Node
var balloonDialogueLabel: DialogueLabel

var speechStreamPaths = {
	"Test": [
		"res://assets/audio/speakers/Voice_Test_-_Boh4.wav",
		"res://assets/audio/speakers/Voice_Test_-_Ee4.wav",
		"res://assets/audio/speakers/Voice_Test_-_Zuh4.wav",
		]
}

var speechStreamResources: Array[AudioStream] = []

func setSpeaker(speaker: String):
	for path in speechStreamPaths[speaker]:
		speechStreamResources.append(load(path))

func _on_speech_player_finished():	
	if (isTalking and len(speechStreamResources) > 0):
		triggerSpeechPlayer()
		
func setBalloonReference(balloon: Node):
	balloonReference = balloon
	balloonDialogueLabel = balloonReference.dialogue_label
	balloonDialogueLabel.paused_typing.connect(onTypingPaused)
	balloonDialogueLabel.spoke.connect(onTypingStarted)
	balloonDialogueLabel.finished_typing.connect(onTypingStopped)
	
func onTypingStopped():
	isTalking = false
	
func onTypingPaused(_delay):
	isTalking = false
	
func onTypingStarted(_a, _b, _c):
	if(!isTalking):
		isTalking = true
		_on_speech_player_finished()
		
func triggerSpeechPlayer():
	speechPlayer.stream = speechStreamResources.pick_random()
	speechPlayer.pitch_scale = randf_range(0.88, 1.15)
	speechPlayer.play()
	
	
