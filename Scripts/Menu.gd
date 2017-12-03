extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var creditPanel
var menuPanel
var AnimationLabel

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	creditPanel = get_node("CreditPanel")
	menuPanel = get_node("MenuPanel")
	AnimationLabel = get_node("MenuPanel/AnimationPlayer")
	
	if AnimationLabel == null:
		pass
	else:
		AnimationLabel.play("LDJAM_MainMenu")
	pass


func _on_ButtonPlay_pressed():
	Global.Scene_Load("res://Scenes/Combat.tscn")
	pass # replace with function body


func _on_ButtonCredits_pressed():
	pass # replace with function body
