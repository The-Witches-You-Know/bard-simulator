extends StaticBody2D

@export var location_name : String
@export var texture : Texture2D

func _ready():
	$Sprite2D.texture = texture

func _input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		
		CallbackHandler.location_to_load = location_name
		
		create_tween().tween_callback(func():
			Audio_Player.setBalloonReference(DialogueManager.show_example_dialogue_balloon(load("res://dialogue/confirm_travel.dialogue"), "start"))
			).set_delay(0.4)

# When the mouse enters we set the outline size to 2
func _on_mouse_entered():
	$Sprite2D.material.set_shader_parameter("width", 2.0)

# When the mouse exits we set the outline size to 0
func _on_mouse_exited():
	$Sprite2D.material.set_shader_parameter("width", 0.0)
	
func _dialogue_confirmation_signal(response):
	if response:
		var game_world = get_node("/root/Main/GameWorld") as GameWorld
		game_world.switch_level(location_name)
