extends Node

var boundaryMin: Vector2 = Vector2()
var boundaryMax: Vector2 = Vector2()

@onready var boundary: StaticBody2D = $RoomBoundary/BoundaryShape
@onready var player: PlayerBody = $player


# Called when the node enters the scene tree for the first time.
func _ready():
	boundaryMin.y = ((boundary.get_child(0) as CollisionShape2D).shape as SegmentShape2D).a.y
	boundaryMin.x = ((boundary.get_child(1) as CollisionShape2D).shape as SegmentShape2D).a.x
	boundaryMax.y = ((boundary.get_child(2) as CollisionShape2D).shape as SegmentShape2D).a.y
	boundaryMax.x = ((boundary.get_child(3) as CollisionShape2D).shape as SegmentShape2D).a.x
	player.setCameraLimit(boundaryMin, boundaryMax)
