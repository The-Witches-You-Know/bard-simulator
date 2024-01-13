extends Node

@onready var masterVolumeSlider: HSlider = $MasterVolume/MasterVolumeSlider
@onready var musicVolumeSlider: HSlider = $MusicVolume/MusicVolumeSlider
@onready var ambientVolumeSlider: HSlider = $AmbientVolume/AmbientVolumeSlider
@onready var SFXVolumeSlider: HSlider = $SFXVolume/SFXVolumeSlider

@onready var returnButton: Button = $ReturnButton


# Called when the node enters the scene tree for the first time.
func _ready():
	masterVolumeSlider.value = Save_Loader.settingsData.getMasterVolume()
	musicVolumeSlider.value = Save_Loader.settingsData.getMusicVolume()
	ambientVolumeSlider.value = Save_Loader.settingsData.getSFXVolume()
	SFXVolumeSlider.value = Save_Loader.settingsData.getAmbienceVolume()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_master_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMasterVolume(value)
func _on_music_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMusicVolume(value)
func _on_sfx_volume_slider_value_changed(value):
	Save_Loader.settingsData.setSFXVolume(value)
func _on_ambient_volume_slider_value_changed(value):
	Save_Loader.settingsData.setAmbienceVolume(value)


func _on_sfx_volume_slider_drag_started():
	Audio_Player.setSpeaker("Test")
	Audio_Player.onTypingStarted(0,0,0)


func _on_sfx_volume_slider_drag_ended(value_changed):
	Audio_Player.onTypingStopped()


