extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var ambiencePlayer: AudioStreamPlayer = $AmbiencePlayer
@onready var speechPlayer: AudioStreamPlayer = $SpeechPlayer
@onready var SFXPlayer: AudioStreamPlayer = $SFXPlayer

var isTalking: bool
var balloonReference: Node
var balloonDialogueLabel: DialogueLabel

var next_track

var speechStreamPaths = {
	"Test": [
		"res://assets/audio/speakers/Voice_Test_-_Boh4.wav",
		"res://assets/audio/speakers/Voice_Test_-_Ee4.wav",
		"res://assets/audio/speakers/Voice_Test_-_Zuh4.wav",
		]
}

var musicStreams = {
	"menu": "",
	"tavern_day": preload("res://assets/audio/music/Tavern_Day_1.0.wav") as AudioStream,
	"tavern_night": "",
	"forest_day": "",
	"forest_night": "",
	"market_day": "",
	"market_night": ""
}

func setMusic(id: String):
	next_track = id
	var prev_volume = $MusicPlayer.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_db", -50, 2)
	tween.tween_callback(Callable(self, "on_fade"))
	tween.tween_property($MusicPlayer, "volume_db", prev_volume, 3)

func on_fade():
	$MusicPlayer.stream = musicStreams[next_track]
	$MusicPlayer.play()

var speechStreamResources: Array[AudioStream] = []

func setSpeaker(speaker: String):
	for path in speechStreamPaths[speaker]:
		speechStreamResources.append(load(path))

func _on_speech_player_finished():	
	if isTalking:
		triggerSpeechPlayer()
		
func setBalloonReference(balloon: Node):
	speechStreamResources = []
	balloonReference = balloon
	balloonDialogueLabel = balloonReference.dialogue_label
	balloonDialogueLabel.paused_typing.connect(onTypingPaused)
	balloonDialogueLabel.spoke.connect(onTypingStarted)
	balloonDialogueLabel.finished_typing.connect(onTypingStopped)
	
func onTypingStopped():
	isTalking = false
	if GameStateHolder.currentSpeaker != null:
		GameStateHolder.currentSpeaker.idle(true)
	
func onTypingPaused(_delay):
	isTalking = false
	if GameStateHolder.currentSpeaker != null:
		GameStateHolder.currentSpeaker.idle(false)
	
func onTypingStarted(_a, _b, _c):
	if(!isTalking):
		isTalking = true
		_on_speech_player_finished()
	if GameStateHolder.currentSpeaker != null and balloonReference.character_label.text != "":
		GameStateHolder.currentSpeaker.talk(balloonReference.character_label.text)
		
func triggerSpeechPlayer():
	if len(speechStreamResources) > 0:
		speechPlayer.stream = speechStreamResources.pick_random()
		speechPlayer.pitch_scale = randf_range(0.88, 1.15)
		speechPlayer.play()
