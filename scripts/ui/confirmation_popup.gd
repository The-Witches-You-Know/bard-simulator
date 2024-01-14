extends Control

signal _on_confirmation_popup(response)
@export var message: String

func _ready():
	$VBoxContainer/Panel/Label.text = message

func _on_confirm_button_up():
	_on_confirmation_popup.emit(true)

func _on_cancel_button_up():
	_on_confirmation_popup.emit(false)
