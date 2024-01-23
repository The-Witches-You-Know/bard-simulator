extends Control

func _ready():
	$AnimationPlayer.play("welcome")

func _on_animation_finished(_anim_name):
	var ui = get_node("/root/Main/UI") as interface
	ui.LoadingSceneRef.play_transition("fade_out2", Callable(self, "transition_callback"), "fade_in2")

func transition_callback():
	visible = false
