extends StaticBody2D

@export var location_name : String
@export var texture : Texture2D

func _ready():
	$Sprite2D.texture = texture

func _input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		var game_world = get_node("/root/Main/GameWorld") as GameWorld
		game_world.switch_level(location_name)

# When the mouse enters we set the outline size to 2
func _on_mouse_entered():
	$Sprite2D.material.set_shader_parameter("width", 2.0)

# When the mouse exits we set the outline size to 0
func _on_mouse_exited():
	$Sprite2D.material.set_shader_parameter("width", 0.0)
