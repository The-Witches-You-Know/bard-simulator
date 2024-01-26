extends Control

class_name Credits

@onready var line = $Line

const line_time = 0.3
const base_speed = 100
const multiplier = 10.0

var scroll_speed = base_speed
var speed_up = false
var is_loaded = false
var line_timer = 0.0
var lines = []
var playing = false

var credits_text = [
	"Thanks for Playing",
	"",
	"",
	"Programmers:",
	"Rethagos",
	"Lazza",
	"",
	"",
	"Art by:",
	"Murosakiiro",
	"",
	"",
	"Story written by:",
	"Agnes",
	"",
	"",
	"Music by:",
	"Robert M. Bach",
	"",
	"",
	"Credit to:",
	"nathanhoad for DialogueManager Plugin for Godot 4"
]

var credits

func _on_skip_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.MENU)

func start():
	$AnimationPlayer.play("reveal_skip_button")
	credits = credits_text.duplicate()
	is_loaded = false
	line_timer = 0.0
	playing = true
	lines.clear()

func _process(delta):
	if !playing:
		return
	
	scroll_speed = base_speed * delta
	
	if speed_up:
		scroll_speed *= multiplier
		line_timer += delta * multiplier
	else:
		line_timer += delta
	
	if line_timer >= line_time:
		line_timer -= line_time
		add_line()
	
	if lines.size() > 0:
		
		for l in lines:
			l.position.y -= scroll_speed
			if l.position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	
	if is_loaded && lines.size() == 0:
		var main = get_node("/root/Main") as Manager
		main.switch_state(global.MENU)
		playing = false

func add_line():
	var new_line = line.duplicate()
	var text = credits.pop_front()
	
	if text != null:
		new_line.text = text
		lines.append(new_line)
		$Panel/MarginContainer/Control.add_child(new_line)
	else:
		is_loaded = true

func _unhandled_input(event):
	if event.is_action_pressed("character_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("character_down") and !event.is_echo():
		speed_up = false
