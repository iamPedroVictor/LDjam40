extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var text1
var text2
var button

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	text1 = get_node("Text1")
	text2 = get_node("Text2")
	button = get_node("Button")
	text2.hide()
	button.hide()
	pass


func _on_Button_pressed():
	Global.Scene_Load("res://Scenes/Menu.tscn")
	pass # replace with function body


func _on_Timer_timeout():
	text1.hide()
	text2.show()
	button.show()
	pass # replace with function body
