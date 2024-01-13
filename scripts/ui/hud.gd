extends Control
class_name HUDInterface

var day = 1
var time_of_day = "Morning"

func _ready():
	$MarginContainer/VBoxContainer/Label.text = "Day " + str(day) + " - " + time_of_day

func set_day(new_day):
	day = new_day
	$MarginContainer/VBoxContainer/Label.text = "Day " + str(day) + " - " + time_of_day
	
func set_time_of_day(new_time_of_day):
	time_of_day = new_time_of_day
	
	match new_time_of_day:
		0:
			time_of_day = "Morning"
		1:
			time_of_day = "Mid-Day"
		2:
			time_of_day = "Evening"
		3:
			time_of_day = "Night"
	
	$MarginContainer/VBoxContainer/Label.text = "Day " + str(day) + " - " + time_of_day
