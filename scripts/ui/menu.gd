extends Control


func _ready():
	$Panel/MarginContainer/VBoxContainer/MainMenuPanel/Continue.visible = GameStateHolder.PeopleSpokenTo != [
		[false,false,false],[false, false, false, false, false, false, false],[false, false, false, false, false, false]
	]
	$ConfirmationPopup.visible = false
	$Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.returnButton.button_up.connect(_on_return_button_button_up)

func _on_continue_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.GAME_WORLD)

func _on_new_game_button_up():
	if $Panel/MarginContainer/VBoxContainer/MainMenuPanel/Continue.visible:
		$ConfirmationPopup.visible = true
	else:
		_on_confirmation_popup(true)

func _on_confirmation_popup(response):
	if(response):
		Save_Loader.clearSaveFile()
		var main = get_node("/root/Main") as Manager
		main.switch_state(global.GAME_WORLD)
	
	$ConfirmationPopup.visible = false

func _on_return_button_button_up():
	$Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.visible = false
	$Panel/MarginContainer/VBoxContainer/MainMenuPanel.visible = true

func _on_options_button_up():
	$Panel/MarginContainer/VBoxContainer/MainMenuPanel.visible = false
	$Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.visible = true
	var sm = $Panel/MarginContainer/VBoxContainer/SettingsMenuPanel as SettingsMenu
	sm.update_values()

func _on_credits_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.CREDITS)


func _on_exit_game_button_up():
	get_tree().quit()
