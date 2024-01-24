extends Control

func _ready():
	$MarginContainer/Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.returnButton.button_up.connect(_on_return_button_button_up)

func _on_continue_button_up():
	var main = get_node("/root/Main") as Manager
	main.switch_to_last_state()

func _on_options_button_up():
	$MarginContainer/Panel/MarginContainer/VBoxContainer/PausedLabel.visible = false
	$MarginContainer/Panel/MarginContainer/VBoxContainer/OptionsLabel.visible = true
	$MarginContainer/Panel/MarginContainer/VBoxContainer/MainPaused.visible = false
	$MarginContainer/Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.visible = true
	
	var sm = $MarginContainer/Panel/MarginContainer/VBoxContainer/SettingsMenuPanel as SettingsMenu
	sm.update_values()

func _on_exit_button_up():
	# SAVE GAME HERE
	
	# Dialogue hack REFER TO THIS WHEN WE CHANGE THE BALLOON
	var dialogue = get_node_or_null("/root/Main/ExampleBalloon")
	
	if dialogue != null:
		dialogue.queue_free()
	
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.MENU)
	
func _on_return_button_button_up():
	$MarginContainer/Panel/MarginContainer/VBoxContainer/PausedLabel.visible = true
	$MarginContainer/Panel/MarginContainer/VBoxContainer/OptionsLabel.visible = false
	$MarginContainer/Panel/MarginContainer/VBoxContainer/MainPaused.visible = true
	$MarginContainer/Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.visible = false
