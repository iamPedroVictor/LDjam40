extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(int)var turnIndex = 0
var heroesAlive
var Warrior
var Mage
var Ranger

var enemies = []
var heroes = []

var ListOrder = []
var orderIndex = 0

var PanelSpells
var PanelTarget
var PanelMenu
var turnLabel
const labelText = "Turn:%s"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	PanelSpells = get_node("PanelSpells")
	PanelSpells.hide()
	PanelTarget = get_node("PanelTargetOptions")
	PanelTarget.hide()
	PanelMenu = get_node("PanelMenu")
	heroes = LoadHeroes()
	enemies = CreateEnemies()
	ListOrder = LoadList()
	turnIndex = 0
	orderIndex = 0
	turnLabel = get_node("TurnLabel")
	heroesAlive = heroes.size()
	Start()
	pass

func Start():
	SetTurnLabel(turnIndex)
	orderIndex = -1
	ChangeTheTurnChar()

func SetTurnLabel(turnValue):
	var text = labelText % (turnValue + 1)
	turnLabel.set_text(text)

func DebugList(List):
	for el in List:
		print(el.get_name())

func ChangeTheTurnChar():
	var lastIndex = orderIndex
	orderIndex += 1
	ChangeIndicate(lastIndex, orderIndex)
	
	if orderIndex >= ListOrder.size():
		PassTurn()
	else:
		if ListOrder[orderIndex].get_groups().count("Hero"):
			LoadMenu(ListOrder[orderIndex])
		else:
			LoadEnemy(ListOrder[orderIndex])
	

func ChangeIndicate(lastOrderIndex, newOrderIndex):
	var last = ListOrder[lastOrderIndex].get_children()
	for l in last:
		if l.get_name() == "Seta":
			if l.is_visible():
				TurnOffNode(l)
			break
	var newIndex = ListOrder[lastOrderIndex].get_children()
	for n in newIndex:
		if n.get_name() == "Seta":
			print(n.get_name())
			if n.is_visible() == false:
				n.show()
			break

func LoadEnemy(_enemy):
	TurnOffNode(PanelMenu)
	_enemy.EnemyTurn()

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
	#heroes.append(Warrior)
	var heroesList = get_tree().get_nodes_in_group("Hero")
	return heroesList

func PassTurn():
	orderIndex = -1
	turnIndex+=1
	SetTurnLabel(turnIndex)
	for h in heroes:
		h.LoseExp(200)
	ChangeTheTurnChar()
	pass
	
func LoadMenu(Hero):
	TurnOffNode(get_node("PanelMenu/GridContainerMenu/ButtonItens"))
	if PanelTarget.is_visible():
		DeleteButtonsTarget()
		TurnOffNode(PanelTarget)
	if PanelSpells.is_visible():
		TurnOffNode(PanelSpells)
	if !PanelMenu.is_visible():
		PanelMenu.show()
	pass

func TurnOffNode(node):
	#node.set_process(false)
	node.hide()

func LoadAttackMenu(Hero):
	if !PanelTarget.is_visible():
		PanelTarget.show()
	var backButton = load("res://Scenes/Button.tscn").instance()
	var funcEnemy = funcref(Hero,"AttackAction")
	for enemy in enemies:
		var panel = get_node("PanelTargetOptions/GridContainer")
		var enemyOption = load("res://Scenes/Button.tscn").instance()
		if enemy.is_visible():
			enemyOption.SetTextButton(enemy.enemyName)
			enemyOption.SetFunctionButton(funcEnemy, enemy)
			panel.add_child(enemyOption)
	var backFunc = funcref(self,"LoadMenu")
	backButton.SetTextButton("Back")
	backButton.SetFunctionButton(backFunc, Hero)
	get_node("PanelTargetOptions/GridContainer").add_child(backButton)
	
func _on_ButtonPass_pressed():
	ChangeTheTurnChar()
	print("Passei meu turno")

func DeleteButtonsTarget():
	var gridTarget = get_node("PanelTargetOptions/GridContainer")
	var buttonTarget = gridTarget.get_children()
	for b in buttonTarget:
		b.Delete()

func _on_ButtonAttack_pressed():
	LoadAttackMenu(ListOrder[orderIndex])
	pass # replace with function body

func HeroDie():
	heroesAlive-=1
	if heroesAlive <= 0:
		GameOver()

func GameOver():
	Global.Scene_Load("GameOver")