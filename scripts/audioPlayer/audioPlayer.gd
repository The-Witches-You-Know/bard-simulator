extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var ambiencePlayer: AudioStreamPlayer = $AmbiencePlayer
@onready var speechPlayer: AudioStreamPlayer = $SpeechPlayer
@onready var SFXPlayer: AudioStreamPlayer = $SFXPlayer

var talkDuration: float = 0.0
var talkTime: float = 0.0

var speechStreamPaths = {
	"Test": "res://assets/audio/squeak2.mp3"
}

func talk(speaker: String, duration: float):
	speechPlayer.stream = load(speechStreamPaths[speaker])
	speak(duration)

func speak(duration: float):	
	talkTime = 0
	talkDuration = duration
	_on_speech_player_finished()

func _on_speech_player_finished():	
	if (talkTime <= talkDuration):
		speechPlayer.pitch_scale = randf_range(0.9, 1.1)
		speechPlayer.play()
		talkTime += speechPlayer.stream.get_length()
