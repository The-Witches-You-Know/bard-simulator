extends Control
class_name EndGame

var can_exit = false

func _unhandled_key_input(event):
	if !can_exit:
		return
	
	if event.is_pressed():
		var main = get_node("/root/Main") as Manager
		main.switch_state(global.CREDITS)
		can_exit = false

func load_endgame():
	$AnimationPlayer.play("end_screen_continue")

func _on_animation_finished(anim_name):
	can_exit = true
