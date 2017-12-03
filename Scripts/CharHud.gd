extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var LifeBar
var Seta
var lvLabel

const labelLvText = "Lv%s"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	LifeBar = get_node("./LifeBar")
	Seta = get_node("./Seta")
	lvLabel = get_node("./LvLabel")
	pass

func SetLv(value):
	var labelText = labelLvText % value
	lvLabel.set_text(labelText)

func ChangeLifeBar(value):
	LifeBar.set_value(value)

func SetLifeBar(_min, _max):
	LifeBar.set_min(_min)
	LifeBar.set_max(_max)