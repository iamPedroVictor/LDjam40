extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_BackToMenu_pressed():
	Global.Scene_Load("res://Scenes/Menu.tscn")
	pass # replace with function body


func _on_PlayAgain_pressed():
	Global.Scene_Load("res://Scenes/Combat.tscn")
	pass # replace with function body
