@tool
extends StaticBody2D

class_name ISpeaker
var hasBeenSpokenTo: bool = false
	
func talk(nameInBalloon: String):
	pass
	
func idle(resetAnimName: bool):
	pass
	
func play(animationName):	
	pass
	
func onConversationStarted():
	pass
	
func onConversationFinished():
	pass
	
	

