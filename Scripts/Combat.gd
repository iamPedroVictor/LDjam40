extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int)var turnIndex = 0

var Warrior
var Mage
var Ranger

var enemies = []
var heroes = []

var ListOrder = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	LoadHeroes()
	enemies = CreateEnemies()
	ListOrder = LoadList()
	turnIndex = 0
	pass

func DebugList(List):
	for el in List:
		print(el.get_name())

func CreateEnemies():
	return get_tree().get_nodes_in_group("Enemies")
	
func LoadList():
	var chars = get_tree().get_nodes_in_group("Char")
	var listReturn = []
	while(chars.size() > 0):
		var posiArray = (randi()%chars.size())
		listReturn.append(chars[posiArray])
		chars.remove(posiArray)
	return listReturn
	 

func LoadHeroes(): 
	Warrior = get_node("Heroes/Warrior")
#	Mage = get_node("Heroes/Mage")
#	Ranger = get_node("Heroes/Ranger")
	heroes.append(Warrior)
	pass

func PassTurn():
	turnIndex+=1
	for h in heroes:
		h.LoseExp()
	pass
	
func LoadMenu(Hero):
	
	pass
	
func LoadAttackMenu():
	for enemy in enemies:
		var panel = get_node("PanelAttackOptions/GridContainer")
		var enemyOption = Button.new()
		if enemy.is_visible():
			enemyOption.set_text(enemy.get_name())
			panel.add_child(enemyOption)