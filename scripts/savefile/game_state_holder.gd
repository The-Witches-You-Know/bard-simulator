extends Node

class_name GameState

var SpokeToOrcDayOneMorning: bool = false: set = setSpokeToOrcDayOneMorning
var SpokeToTavernkeepDayOneMorning: bool = false: set = setSpokeToTavernkeepDayOneMorning
var SpokeToOldBardDayOneMorning: bool = false: set = setSpokeToOldBardDayOneMorning

func initGameState():
	var savedData = Save_Loader.gameData
	SpokeToOrcDayOneMorning = savedData.safeGet("Orc.SpokeTo.Day1.Morning", false)
	SpokeToTavernkeepDayOneMorning = savedData.safeGet("Tavernkeep.SpokeTo.Day1.Morning", false)
	SpokeToOldBardDayOneMorning = savedData.safeGet("OldBard.SpokeTo.Day1.Morning", false)
	
func setSpokeToOrcDayOneMorning(newValue):
	SpokeToOrcDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("Orc.SpokeTo.Day1.Morning", newValue)
	
func setSpokeToTavernkeepDayOneMorning(newValue):
	SpokeToTavernkeepDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("Tavernkeep.SpokeTo.Day1.Morning", newValue)
	
func setSpokeToOldBardDayOneMorning(newValue):
	SpokeToOldBardDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("OldBard.SpokeTo.Day1.Morning", newValue)
