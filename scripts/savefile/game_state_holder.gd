extends Node

class_name GameState

var SpokeToOrcDayOneMorning: bool = false: set = setSpokeToOrcDayOneMorning
var SpokeToTavernkeepDayOneMorning: bool = false: set = setSpokeToTavernkeepDayOneMorning
var SpokeToOldBardDayOneMorning: bool = false: set = setSpokeToOldBardDayOneMorning

var SpokeToKidsDayOneNoon: bool = false: set = setSpokeToKidsDayOneNoon
var SpokeToTavernkeepDayOneNoon: bool = false: set = setSpokeToTavernkeepDayOneNoon
var SpokeToMarketWitchDayOneNoon: bool = false: set = setSpokeToMarketWitchDayOneNoon
var SpokeToFarmerDayOneNoon: bool = false: set = setSpokeToFarmerDayOneNoon

var SpokeToOrcDayOneEvening: bool = false: set = setSpokeToOrcDayOneEvening
var SpokeToFarmerDayOneEvening: bool = false: set = setSpokeToFarmerDayOneEvening

var KnowsAboutOrcStory: bool = false: set = setKnowsAboutOrcStory
var KnowsOrcLied: bool = false: set = setKnowsOrcLied
var FarmerAngry: bool = false: set = setFarmerAngry
var KnowsAboutAdventurers: bool = false: set = setKnowsAboutAdventurers

var currentLevel: String = "tavern": set = setCurrentLevel

var currentSpeaker: Speaker = null
var currentLevelNode: Level = null

var expectedSpokenToIndices = {
	"Tavern": [
		[0,1,2],
		[1],
		[0]
	],
	"Forest": [
		[],
		[0,3],
		[1]
	],
	"Town": [
		[],
		[2],
		[]
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
		false, #farmer
		
	],
	[ #day1 evening
		false, #orc
		false, #farmer
	]
]
var Day1StoryChoices = [ # If specific story choice chains not listed out - choices have little meaning. -1 is default value
	-1, # [0|1|2|3|4]  - [Heroic Orc|Orc claimed kill|Orc Superhero|Drake Diseased|Drake flew into windmill] 
	-1, # [Heroic Orc] - [0|1|2] [Middle of action | Exposition | Tragic Backstory]
	-1, # [Heroic Orc] - [Middle of action] - [0|1] [Senseless action | Orc monologue]
		#                [Exposition] - [0|1] [Actual Beginning | Embellish]
		#                [Tragic Backstory] - [0|1] [Buildup | Close to truth]
	-1, # [Heroic Orc] - [Exposition, Embellish] or [Tragic Backstory, Buildup] - [0|1] [Epic clash, Cut the tension]
		#                [Tragic Backstory, Close to truth] - [0|1] [Remain true | Embellish the Ending]
	-1
]

var currentDay: int = 1 : set = setCurrentDay
var timeOfDay: int = 0 : set = setTimeOfDay

func initGameState():
	var savedData = Save_Loader.gameData
		
	PeopleSpokenTo = savedData.safeGet("PeopleSpokenTo", [[false,false,false],[false, false, false, false],[false, false]])
	Day1StoryChoices = savedData.safeGet("Day1.StoryChoices", [-1,-1,-1,-1,-1])
	
	SpokeToOrcDayOneMorning = PeopleSpokenTo[0][0]
	SpokeToTavernkeepDayOneMorning = PeopleSpokenTo[0][1]
	SpokeToOldBardDayOneMorning = PeopleSpokenTo[0][2]
	
	SpokeToKidsDayOneNoon = PeopleSpokenTo[1][0]
	SpokeToTavernkeepDayOneNoon = PeopleSpokenTo[1][1]
	SpokeToMarketWitchDayOneNoon = PeopleSpokenTo[1][2]
	SpokeToFarmerDayOneNoon = PeopleSpokenTo[1][3]
	
	SpokeToOrcDayOneEvening = PeopleSpokenTo[2][0]
	SpokeToFarmerDayOneEvening = PeopleSpokenTo[2][1]	
	
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

func setCurrentDay(newValue):
	currentDay = newValue
	SaveLoader.gameData.setOrPut("CurrentDay", newValue)

func setTimeOfDay(newValue):
	timeOfDay = newValue
	SaveLoader.gameData.setOrPut("TimeOfDay", newValue)
	
func setCurrentSpeaker(speaker: Speaker):
	currentSpeaker = speaker
