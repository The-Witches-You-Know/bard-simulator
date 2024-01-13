extends Node
class_name GameWorld

@export var dict : Dictionary

var current : Node2D

func _ready():
	switch_level("map")

func switch_level(level):
	if current != null:
		current.queue_free()

	if level in dict:
		current = load(dict[level]).instantiate()
		add_child(current)
