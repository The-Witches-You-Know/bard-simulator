extends Node

class_name GameState

var SpokeToOrcDayOneMorning: bool = false: set = setSpokeToOrcDayOneMorning
var KnowsAboutOrcStory: bool = false: set = setKnowsAboutOrcStory
var KnowsOrcLied: bool = false: set = setKnowsOrcLied
var OrcLie: bool = false: set = setOrcLie


var SpokeToTavernkeepDayOneMorning: bool = false: set = setSpokeToTavernkeepDayOneMorning
var SpokeToOldBardDayOneMorning: bool = false: set = setSpokeToOldBardDayOneMorning

func initGameState():
	var savedData = Save_Loader.gameData
	SpokeToOrcDayOneMorning = savedData.safeGet("Orc.SpokeTo.Day1.Morning", false)
	KnowsAboutOrcStory = savedData.safeGet("KnowsAboutOrcStory", false)
	KnowsOrcLied = savedData.safeGet("KnowsOrcLied", false)
	OrcLie = savedData.safeGet("OrcLie", false)
	SpokeToTavernkeepDayOneMorning = savedData.safeGet("Tavernkeep.SpokeTo.Day1.Morning", false)
	SpokeToOldBardDayOneMorning = savedData.safeGet("OldBard.SpokeTo.Day1.Morning", false)
	
func setSpokeToOrcDayOneMorning(newValue):
	SpokeToOrcDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("Orc.SpokeTo.Day1.Morning", newValue)
	
func setKnowsAboutOrcStory(newValue):
	KnowsAboutOrcStory = newValue
	SaveLoader.gameData.setOrPut("KnowsAboutOrcStory", newValue)
	
func setKnowsOrcLied(newValue):
	KnowsOrcLied = newValue
	SaveLoader.gameData.setOrPut("KnowsOrcLied", newValue)
	
func setOrcLie(newValue):
	OrcLie = newValue
	SaveLoader.gameData.setOrPut("OrcLie", newValue)
	
func setSpokeToTavernkeepDayOneMorning(newValue):
	SpokeToTavernkeepDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("Tavernkeep.SpokeTo.Day1.Morning", newValue)
	
func setSpokeToOldBardDayOneMorning(newValue):
	SpokeToOldBardDayOneMorning = newValue
	SaveLoader.gameData.setOrPut("OldBard.SpokeTo.Day1.Morning", newValue)
