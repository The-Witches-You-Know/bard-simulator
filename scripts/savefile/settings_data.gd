extends SaveData

class_name SettingsData

func _init():
	fileName = "settings"
	saveFile = ConfigFile.new()

# set sound volume. Permitted values: 0 - 100
func setSoundVolume(value: int):
	setOrPut("Settings.SoundVolume", max(0, min(100, value)))
func getSoundVolume() -> int:
	return safeGet("Settings.SoundVolume", 100)

# set music volume. Permitted values: 0 - 100
func setMusicVolume(value: int):
	setOrPut("Settings.MusicVolume", max(0, min(100, value)))
func getMusicVolume() -> int:
	return safeGet("Settings.MusicVolume", 100)

# set master volume. Permitted values: 0 - 100
func setMasterVolume(value: int):
	setOrPut("Settings.MasterVolume", max(0, min(100, value)))
func getMasterVolume() -> int:
	return safeGet("Settings.MasterVolume", 100)
