extends Control

func _on_continue_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_to_last_state()

func _on_options_button_up():
	pass # Replace with function body.

func _on_exit_button_up():
	pass # Replace with function body.
