extends Node

class_name GameState

var SpokeToOrcDayOneMorning: bool = false: set = setSpokeToOrcDayOneMorning
var SpokeToTavernkeepDayOneMorning: bool = false: set = setSpokeToTavernkeepDayOneMorning
var SpokeToOldBardDayOneMorning: bool = false: set = setSpokeToOldBardDayOneMorning

var SpokeToKidsDayOneNoon: bool = false: set = setSpokeToKidsDayOneNoon
var SpokeToTavernkeepDayOneNoon: bool = false: set = setSpokeToTavernkeepDayOneNoon
var SpokeToMarketWitchDayOneNoon: bool = false: set = setSpokeToMarketWitchDayOneNoon
var SpokeToFarmerDayOneNoon: bool = false: set = setSpokeToFarmerDayOneNoon
var SpokeToAdventurersDayOneNoon: bool = false: set = setSpokeToAdventurersDayOneNoon
var SpokeToJugglingGirlDayOneNoon: bool = false: set = setSpokeToJugglingGirlDayOneNoon

var SpokeToOrcDayOneEvening: bool = false: set = setSpokeToOrcDayOneEvening
var SpokeToFarmerDayOneEvening: bool = false: set = setSpokeToFarmerDayOneEvening
var SpokeToTavernkeepDayOneEvening: bool = false: set = setSpokeToTavernkeepDayOneEvening
var SpokeToWitchDayOneEvening: bool = false: set = setSpokeToWitchDayOneEvening

var KnowsAboutOrcStory: bool = false: set = setKnowsAboutOrcStory
var KnowsOrcLied: bool = false: set = setKnowsOrcLied
var FarmerAngry: bool = false: set = setFarmerAngry
var KnowsAboutAdventurers: bool = false: set = setKnowsAboutAdventurers

var currentLevel: String = "tavern": set = setCurrentLevel

var currentSpeaker: ISpeaker = null
var currentLevelNode: Level = null

var expectedSpokenToIndices = {
	"Tavern": [
		[0,1,2],
		[1,4],
		[0,3]
	],
	"Forest": [
		[],
		[0,3],
		[1]
	],
	"Town": [
		[],
		[2,5,6],
		[3]
	]
}


var PeopleSpokenTo = [
	[ #day1 morning
		false, #orc
		false, #tavernkeep
		false, #bard
	],
	[ #day1 noon
		false, #forestkids
		false, #tavernkeep
		false, #marketwitch
		false, #farmer,
		false, #adventurers
		false, #juggling girl,
		false, #outsider merchant
	],
	[ #day1 evening
		false, #orc
		false, #farmer,
		false, #tavernkeep,
		false, #witch
	]
]
var Day1StoryEnding = "" 
#[
#InMediasRes
#OrcMonologue
#EpicClash
#QuickFinish
#GroundedInReality
#Embellished
#PersonalDramas
#Conspiracies
#OrcExile
#RuinedMood
#]

var currentDay: int = 1 : set = setCurrentDay
var timeOfDay: int = 0 : set = setTimeOfDay

func initGameState():
	var savedData = Save_Loader.gameData
		
	PeopleSpokenTo = savedData.safeGet("PeopleSpokenTo", [[false,false,false],[false, false, false, false, false, false, false],[false, false, false, false]])
	if PeopleSpokenTo.map(func(x): return len(x)) != [3,7,4]:
		savedData.clear()
		PeopleSpokenTo = savedData.safeGet("PeopleSpokenTo", [[false,false,false],[false, false, false, false, false, false, false],[false, false, false, false]])
		
	Day1StoryEnding = savedData.safeGet("Day1.StoryEnding", "")
	
	SpokeToOrcDayOneMorning = PeopleSpokenTo[0][0]
	SpokeToTavernkeepDayOneMorning = PeopleSpokenTo[0][1]
	SpokeToOldBardDayOneMorning = PeopleSpokenTo[0][2]
	
	SpokeToKidsDayOneNoon = PeopleSpokenTo[1][0]
	SpokeToTavernkeepDayOneNoon = PeopleSpokenTo[1][1]
	SpokeToMarketWitchDayOneNoon = PeopleSpokenTo[1][2]
	SpokeToFarmerDayOneNoon = PeopleSpokenTo[1][3]
	SpokeToAdventurersDayOneNoon = PeopleSpokenTo[1][4]
	SpokeToJugglingGirlDayOneNoon = PeopleSpokenTo[1][5]
	
	SpokeToOrcDayOneEvening = PeopleSpokenTo[2][0]
	SpokeToFarmerDayOneEvening = PeopleSpokenTo[2][1]	
	SpokeToTavernkeepDayOneEvening = PeopleSpokenTo[2][2]	
	SpokeToWitchDayOneEvening = PeopleSpokenTo[2][3]	
	
	currentDay = savedData.safeGet("CurrentDay", 1)
	timeOfDay = savedData.safeGet("TimeOfDay", 0)
	
	KnowsAboutOrcStory = savedData.safeGet("KnowsAboutOrcStory", false)
	KnowsOrcLied = savedData.safeGet("KnowsOrcLied", false)
	
	FarmerAngry = savedData.safeGet("FarmerAngry", false)
	KnowsAboutAdventurers = savedData.safeGet("KnowsAboutAdventurers", false)
	
	currentLevel = savedData.safeGet("CurrentLevel", "tavern")
	
func setSpokeToOrcDayOneMorning(newValue: bool):
	SpokeToOrcDayOneMorning = newValue
	setDay1PeopleSpokenTo(0,0,newValue)
	
func setCurrentLevel(newValue: String):
	currentLevel = newValue
	SaveLoader.gameData.setOrPut("CurrentLevel", newValue)
	
func setDay1PeopleSpokenTo(index1: int, index2: int, value: bool):
	PeopleSpokenTo[index1][index2] = value
	if(currentLevelNode != null):
		currentLevelNode.onSpokenToStatusChanged()
	SaveLoader.gameData.setOrPut("PeopleSpokenTo", PeopleSpokenTo)
	
	#   ||      ||         ||
	#   \/      \/         \/
func setDay1StoryChoices(index: int,value: bool): #please use this instead of setting values directly inside the Day1StoryChoices array
	Day1StoryChoices[index] = value
	SaveLoader.gameData.setOrPut("Day1.StoryChoices", Day1StoryChoices)

func getPlayerSpokeWithFarmer() -> bool:
	return SpokeToFarmerDayOneNoon or SpokeToFarmerDayOneEvening

func setSpokeToOrcDayOneEvening(newValue: bool):
	SpokeToOrcDayOneEvening = newValue
	setDay1PeopleSpokenTo(2,0,newValue)
	
func setKnowsAboutOrcStory(newValue: bool):
	KnowsAboutOrcStory = newValue
	SaveLoader.gameData.setOrPut("KnowsAboutOrcStory", newValue)
	
func setKnowsOrcLied(newValue: bool):
	KnowsOrcLied = newValue
	SaveLoader.gameData.setOrPut("KnowsOrcLied", newValue)
	
func setFarmerAngry(newValue: bool):
	FarmerAngry = newValue
	SaveLoader.gameData.setOrPut("FarmerAngry", newValue)
	
func setKnowsAboutAdventurers(newValue: bool):
	KnowsAboutAdventurers = newValue
	SaveLoader.gameData.setOrPut("KnowsAboutAdventurers", newValue)
	
func setSpokeToTavernkeepDayOneMorning(newValue: bool):
	SpokeToTavernkeepDayOneMorning = newValue
	setDay1PeopleSpokenTo(0,1,newValue)
	
func setSpokeToTavernkeepDayOneNoon(newValue: bool):
	SpokeToTavernkeepDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,1,newValue)
	
func setSpokeToAdventurersDayOneNoon(newValue: bool):
	SpokeToAdventurersDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,3,newValue)
	
func setSpokeToJugglingGirlDayOneNoon(newValue: bool):
	SpokeToJugglingGirlDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,5,newValue)
	
func setSpokeToKidsDayOneNoon(newValue: bool):
	SpokeToKidsDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,0,newValue)
	
func setSpokeToOldBardDayOneMorning(newValue: bool):
	SpokeToOldBardDayOneMorning = newValue
	setDay1PeopleSpokenTo(0,2,newValue)
	
func setSpokeToMarketWitchDayOneNoon(newValue: bool):
	SpokeToMarketWitchDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,2,newValue)
	
func setSpokeToFarmerDayOneNoon(newValue: bool):
	SpokeToFarmerDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,3,newValue)
	
func setSpokeToFarmerDayOneEvening(newValue: bool):
	SpokeToFarmerDayOneEvening = newValue
	setDay1PeopleSpokenTo(2,1,newValue)	
	
func setSpokeToTavernkeepDayOneEvening(newValue: bool):
	SpokeToTavernkeepDayOneEvening = newValue
	setDay1PeopleSpokenTo(2,2,newValue)	
	
func setSpokeToWitchDayOneEvening(newValue: bool):
	SpokeToWitchDayOneEvening = newValue
	setDay1PeopleSpokenTo(2,3,newValue)	

func setCurrentDay(newValue):
	currentDay = newValue
	SaveLoader.gameData.setOrPut("CurrentDay", newValue)

func setTimeOfDay(newValue):
	timeOfDay = newValue
	SaveLoader.gameData.setOrPut("TimeOfDay", newValue)
	
func setCurrentSpeaker(speaker: ISpeaker):
	currentSpeaker = speaker
