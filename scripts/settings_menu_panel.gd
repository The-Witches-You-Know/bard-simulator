extends Node
class_name SettingsMenu

# Ambient sounds removed for now

@onready var masterVolumeSlider: HSlider = $MasterVolume/MasterVolumeSlider
@onready var musicVolumeSlider: HSlider = $MusicVolume/MusicVolumeSlider
#@onready var ambientVolumeSlider: HSlider = $AmbientVolume/AmbientVolumeSlider
@onready var SFXVolumeSlider: HSlider = $SFXVolume/SFXVolumeSlider

@onready var returnButton: TextureButton = $ReturnButton

func _ready():
	update_values()

func update_values():
	masterVolumeSlider.value = Save_Loader.settingsData.getMasterVolume()
	musicVolumeSlider.value = Save_Loader.settingsData.getMusicVolume()
	#ambientVolumeSlider.value = Save_Loader.settingsData.getAmbienceVolume()
	SFXVolumeSlider.value = Save_Loader.settingsData.getSFXVolume()	

func _on_master_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMasterVolume(value)
func _on_music_volume_slider_value_changed(value):
	Save_Loader.settingsData.setMusicVolume(value)
func _on_sfx_volume_slider_value_changed(value):
	Save_Loader.settingsData.setSFXVolume(value)
	Audio_Player.triggerSpeechPlayer()
#func _on_ambient_volume_slider_value_changed(value):
	#Save_Loader.settingsData.setAmbienceVolume(value)

func _on_sfx_volume_slider_drag_started():
	Audio_Player.setSpeaker("Test")
	Audio_Player.triggerSpeechPlayer()


