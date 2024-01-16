extends Node

class_name GameState

var SpokeToOrcDayOneMorning: bool = false: set = setSpokeToOrcDayOneMorning
var SpokeToOrcDayOneEvening: bool = false: set = setSpokeToOrcDayOneEvening
var KnowsAboutOrcStory: bool = false: set = setKnowsAboutOrcStory
var KnowsOrcLied: bool = false: set = setKnowsOrcLied
var OrcLie: bool = false: set = setOrcLie

var Day1PeopleSpokenTo = [
	[ #morning
		false, #orc
		false, #tavernkeep
		false, #bard
	],
	[ #noon
		false, #forestkids
		false, #tavernkeep
	],
	[ #evening
		false, #orc
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

var SpokeToTavernkeepDayOneMorning: bool = false: set = setSpokeToTavernkeepDayOneMorning
var SpokeToTavernkeepDayOneNoon: bool = false: set = setSpokeToTavernkeepDayOneNoon

var SpokeToKidsDayOneNoon: bool = false: set = setSpokeToKidsDayOneNoon

var SpokeToOldBardDayOneMorning: bool = false: set = setSpokeToOldBardDayOneMorning

func initGameState():
	var savedData = Save_Loader.gameData
	Day1PeopleSpokenTo = savedData.safeGet("Day1.PeopleSpokenTo", [[false,false,false],[false, false],[false]])
	Day1StoryChoices = savedData.safeGet("Day1.StoryChoices", [-1,-1,-1,-1,-1])
	
	SpokeToOrcDayOneMorning = Day1PeopleSpokenTo[0][0]
	SpokeToTavernkeepDayOneMorning = Day1PeopleSpokenTo[0][1]
	SpokeToOldBardDayOneMorning = Day1PeopleSpokenTo[0][2]
	
	SpokeToTavernkeepDayOneNoon = Day1PeopleSpokenTo[1][1]
	SpokeToKidsDayOneNoon = Day1PeopleSpokenTo[1][0]
	
	SpokeToOrcDayOneEvening = Day1PeopleSpokenTo[2][0]
	
	KnowsAboutOrcStory = savedData.safeGet("KnowsAboutOrcStory", false)
	KnowsOrcLied = savedData.safeGet("KnowsOrcLied", false)
	OrcLie = savedData.safeGet("OrcLie", false)	
	
func setSpokeToOrcDayOneMorning(newValue):
	SpokeToOrcDayOneMorning = newValue
	setDay1PeopleSpokenTo(0,0,true)
	
func setDay1PeopleSpokenTo(index1, index2, value):
	Day1PeopleSpokenTo[index1][index2] = value
	SaveLoader.gameData.setOrPut("Day1.PeopleSpokenTo", Day1PeopleSpokenTo)
	
	#   ||      ||         ||
	#   \/      \/         \/
func setDay1StoryChoices(index,value): #please use this instead of setting values directly inside the Day1StoryChoices array
	Day1StoryChoices[index] = value
	SaveLoader.gameData.setOrPut("Day1.StoryChoices", Day1StoryChoices)
	
	
	
func setSpokeToOrcDayOneEvening(newValue):
	SpokeToOrcDayOneEvening = newValue
	setDay1PeopleSpokenTo(2,0,true)
	
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
	setDay1PeopleSpokenTo(0,1,true)
	
func setSpokeToTavernkeepDayOneNoon(newValue):
	SpokeToTavernkeepDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,1,true)
	
func setSpokeToKidsDayOneNoon(newValue):
	SpokeToKidsDayOneNoon = newValue
	setDay1PeopleSpokenTo(1,0,true)
	
func setSpokeToOldBardDayOneMorning(newValue):
	SpokeToOldBardDayOneMorning = newValue
	setDay1PeopleSpokenTo(0,2,true)
