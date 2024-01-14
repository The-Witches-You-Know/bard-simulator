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

func _on_exit_button_up():
	# SAVE GAME HERE
	var main = get_node("/root/Main") as Manager
	main.switch_state(global.MENU)
	
func _on_return_button_button_up():
	$MarginContainer/Panel/MarginContainer/VBoxContainer/PausedLabel.visible = true
	$MarginContainer/Panel/MarginContainer/VBoxContainer/OptionsLabel.visible = false
	$MarginContainer/Panel/MarginContainer/VBoxContainer/MainPaused.visible = true
	$MarginContainer/Panel/MarginContainer/VBoxContainer/SettingsMenuPanel.visible = false
