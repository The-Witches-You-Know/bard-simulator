extends Control

@export var starting_scene: PackedScene

func _ready():
	$ConfirmationPopup.visible = false	

func _on_continue_button_up():
	get_tree().change_scene_to_packed(starting_scene)

func _on_new_game_button_up():
	$ConfirmationPopup.visible = true

func _on_confirmation_popup(response):
	if(response):
		# Clear the save file
		get_tree().change_scene_to_packed(starting_scene)
	
	$ConfirmationPopup.visible = false
