extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var ambiencePlayer: AudioStreamPlayer = $AmbiencePlayer
@onready var speechPlayer: AudioStreamPlayer = $SpeechPlayer
@onready var SFXPlayer: AudioStreamPlayer = $SFXPlayer

var isTalking: bool
var balloonReference: Node
var balloonDialogueLabel: DialogueLabel

var speechStreamPaths = {
	"Test": "res://assets/audio/squeak2.mp3"
}

func setSpeaker(speaker: String):
	speechPlayer.stream = load(speechStreamPaths[speaker])

func _on_speech_player_finished():	
	if (isTalking):
		speechPlayer.pitch_scale = randf_range(0.9, 1.1)
		speechPlayer.play()
		
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
	
