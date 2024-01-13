extends Area2D

var in_range = false

func _process(delta):
	if in_range:
		if Input.is_action_just_released("interact"):
			# Show confirmation message
			pass

func _on_area_entered(area):
	in_range = true

func _on_area_exited(area):
	in_range = false
	
func _on_confirmation_popup(response):
	if response:
		var main = get_node("/root/Main/Game_World") as Manager
