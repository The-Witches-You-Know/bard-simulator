extends Node

@onready var masterVolumeSlider: HSlider = $MasterVolume/MasterVolumeSlider
@onready var musicVolumeSlider: HSlider = $MusicVolume/MusicVolumeSlider
@onready var ambientVolumeSlider: HSlider = $AmbientVolume/AmbientVolumeSlider
@onready var SFXVolumeSlider: HSlider = $SFXVolume/SFXVolumeSlider

@onready var returnButton: Button = $ReturnButton

func _ready():
	masterVolumeSlider.value = Save_Loader.settingsData.getMasterVolume()
	musicVolumeSlider.value = Save_Loader.settingsData.getMusicVolume()
	ambientVolumeSlider.value = Save_Loader.settingsData.getSFXVolume()
	SFXVolumeSlider.value = Save_Loader.settingsData.getAmbienceVolume()

func _on_master_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMasterVolume(value)
func _on_music_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMusicVolume(value)
func _on_sfx_volume_slider_value_changed(value):
	Save_Loader.settingsData.setSFXVolume(value)
	Audio_Player.triggerSpeechPlayer()
func _on_ambient_volume_slider_value_changed(value):
	Save_Loader.settingsData.setAmbienceVolume(value)

func _on_sfx_volume_slider_drag_started():
	Audio_Player.setSpeaker("Test")
	Audio_Player.triggerSpeechPlayer()


