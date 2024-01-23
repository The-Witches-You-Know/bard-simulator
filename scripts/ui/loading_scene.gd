extends Control
class_name LoadingScene	

var transition_callback : Callable
var second_transition
var skip_callback

func _ready():
	$FadeInOut.visible = false

# Use null for transition2 if not needed
func play_transition(transition, callback, transition2):
	$AnimationPlayer.play(transition)
	transition_callback = callback
	second_transition = transition2
	skip_callback = false

# Use null for transition2 if not needed
func play_transition_no_callback(transition, transition2):
	$AnimationPlayer.play(transition)
	second_transition = transition2
	skip_callback = true

func _on_animation_finished(_anim_name):
	
	if !skip_callback:
		transition_callback.call()
	
	if second_transition != null:
		$AnimationPlayer.play(second_transition)
		second_transition = null
		skip_callback = true
