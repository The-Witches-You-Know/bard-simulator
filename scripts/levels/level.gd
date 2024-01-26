extends Node

class_name Level

var boundaryMin: Vector2 = Vector2()
var boundaryMax: Vector2 = Vector2()

@onready var boundary: StaticBody2D = $RoomBoundary/BoundaryShape
@onready var player: PlayerBody = $player
@onready var exitArea: ExitArea = $ExitArea

# Called when the node enters the scene tree for the first time.
func _ready():
	GameStateHolder.currentLevelNode = self
	onSpokenToStatusChanged()
	boundaryMin.y = ((boundary.get_child(0) as CollisionShape2D).shape as SegmentShape2D).a.y
	boundaryMin.x = ((boundary.get_child(1) as CollisionShape2D).shape as SegmentShape2D).a.x
	boundaryMax.y = ((boundary.get_child(2) as CollisionShape2D).shape as SegmentShape2D).a.y
	boundaryMax.x = ((boundary.get_child(3) as CollisionShape2D).shape as SegmentShape2D).a.x
	player.setCameraLimit(boundaryMin, boundaryMax)
	
func onSpokenToStatusChanged():
	exitArea.can_leave = true
	var currentDayStage = (GameStateHolder.currentDay-1) * 3 + GameStateHolder.timeOfDay
	for expectedIndex in GameStateHolder.expectedSpokenToIndices[name][currentDayStage]:
		if !GameStateHolder.PeopleSpokenTo[currentDayStage][expectedIndex]:
			exitArea.can_leave = false
