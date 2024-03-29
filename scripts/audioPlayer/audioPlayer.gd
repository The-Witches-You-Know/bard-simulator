extends Node

@onready var musicPlayer: AudioStreamPlayer = $MusicPlayer
@onready var speechPlayer: AudioStreamPlayer = $SpeechPlayer
@onready var SFXPlayer: AudioStreamPlayer = $SFXPlayer

var isTalking: bool
var balloonReference: Node
var balloonDialogueLabel: DialogueLabel

var next_track

var speechStreamPaths = {
	"Test": [
		"res://assets/audio/speakers/High_Bu.wav",
		"res://assets/audio/speakers/Mid_Oos.wav",
		"res://assets/audio/speakers/Mid_Yu.wav",
		"res://assets/audio/speakers/Low_Yu.wav",
		"res://assets/audio/speakers/Low_Bi.wav",
		]
}

var musicStreams = {
	"menu": preload("res://assets/audio/V_Basic_Cozy_Acoustic.wav") as AudioStream,
	"map": preload("res://assets/audio/music/Map_Theme_Final.ogg") as AudioStream,
	"tavern_day": preload("res://assets/audio/music/Tavern_Day_Final.ogg") as AudioStream,
	"tavern_night": preload("res://assets/audio/music/Tavern_Night_Final.ogg") as AudioStream,
	"forest_day": preload("res://assets/audio/music/Forest_Day_Final.ogg") as AudioStream,
	"forest_night": preload("res://assets/audio/music/Forest_Night_Final.ogg") as AudioStream,
	"town_day": preload("res://assets/audio/music/Market_Day_Final.ogg") as AudioStream,
	"opening": preload("res://assets/audio/music/Opening_Theme_Final.ogg") as AudioStream,
	"closing": preload("res://assets/audio/music/Closing_Theme_Final.ogg") as AudioStream,
	"town_night": null
}

var playersfx = {
	"tavern": preload("res://assets/audio/sfx/Running_on_Wood.wav") as AudioStream, # Wood
	"town": preload("res://assets/audio/sfx/Running_on_Gravel.wav") as AudioStream, # Gravel
	"forest": preload("res://assets/audio/sfx/Running_on_Grass.wav") as AudioStream # Grass
}

func setSFX(id: String):
	if id in playersfx.keys():
		$SFXPlayer.stream = playersfx[id]

# pass stop to stop
func playSFX():
	
	if $SFXPlayer.playing:
		return
	
	$SFXPlayer.play()

func setMusic(id: String):
	next_track = id
	var prev_volume = $MusicPlayer.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_db", -50, 0.8)
	tween.tween_callback(Callable(self, "on_fade"))
	tween.tween_property($MusicPlayer, "volume_db", 0, 0.8)

func muteMusic():
	var tween = get_tree().create_tween()
	tween.tween_property($MusicPlayer, "volume_db", -50, 0.8)
	

func playMusic(id: String):
	next_track = id
	var tween = get_tree().create_tween()
	tween.tween_callback(Callable(self, "on_fade"))
	tween.tween_property($MusicPlayer, "volume_db", 0, 0.8)
	

func on_fade():
	if next_track in musicStreams.keys():
		$MusicPlayer.stream = musicStreams[next_track]
		$MusicPlayer.volume_db = linear_to_db(0.4)
		$MusicPlayer.play()

var speechStreamResources: Array[AudioStream] = []

func setSpeaker(speaker: String):
	speechStreamResources = []
	if len(speaker) > 0 and speaker in speechStreamPaths.keys():
		for path in speechStreamPaths[speaker]:
			speechStreamResources.append(load(path))
	if (isTalking):
		_on_speech_player_finished()
		
func setSpeakerSound(sound: AudioStream):
	speechStreamResources = [sound]
	if (isTalking):
		_on_speech_player_finished()
	

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
