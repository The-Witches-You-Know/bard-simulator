extends Node

class_name SaveLoader

static var gameData: GameData
static var settingsData = SettingsData.new()

func _ready():
	settingsData.loadFile()
	loadSaveFile(0)

#use to load specific save slot
func loadSaveFile(saveSlot: int):
	assert(0 <= saveSlot and saveSlot < 4, "ERROR: SaveSlot must be between 0 and 3.");
	gameData = GameData.new("savefile_"+str(saveSlot))
	gameData.loadFile()

#use to save game into specific save slot
func saveDataIntoSaveSlot(saveSlot: int, saveData: Dictionary):
	assert(0 <= saveSlot and saveSlot  < 4, "ERROR: SaveSlot must be between 0 and 3.");
	gameData = GameData.new("savefile_"+str(saveSlot))
	gameData.overwrite(saveData)

func restoreDefaultSettings():
	settingsData.clear()
