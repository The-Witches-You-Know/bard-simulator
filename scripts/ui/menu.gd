extends Control

func _ready():
	$ConfirmationPopup.visible = false	

func _on_continue_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.GAME_WORLD)

func _on_new_game_button_up():
	$ConfirmationPopup.visible = true

func _on_confirmation_popup(response):
	if(response):
		# Clear the save file
		var main = get_node("/root/Main") as Manager
		main.switch_state(global.GAME_WORLD)
	
	$ConfirmationPopup.visible = false
