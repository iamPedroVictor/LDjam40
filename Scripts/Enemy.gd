extends Node2D

const Orc = 1
const Mage_Orc = 2
const Goblin = 3

var enemyName = ""
var enemyLevel = 20

var lifePoints = 0
var maxLifePoints = 0
var strength = 0
var dexterity = 0
var intelligence = 0
var constitution = 0

var combatNode 

var lastTurnPassed = false

var enemyType
var Hud
var anim
var timeNode

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	enemyType = RandomNumber(1,3)
	combatNode = get_tree().get_root().get_node("Combat")
	anim = get_node("AnimationPlayer")
	Hud = get_node("./HUDBar")
	timeNode = get_parent().get_parent().get_node("Timer")
	GenerateAttributes()
	pass

func GenerateAttributes():
	if(enemyType == Orc):
		strength = RandomNumber(18,22)
		dexterity = RandomNumber(10,16)
		intelligence = RandomNumber(4,15)
		constitution = RandomNumber(18,24)
		maxLifePoints = 30 + getSkillMod(constitution)
		lifePoints = maxLifePoints
		enemyName = "Orc"
	elif(enemyType == Mage_Orc):
		strength = RandomNumber(9,14)
		dexterity = RandomNumber(10,16)
		intelligence = RandomNumber(18,24)
		constitution = RandomNumber(16,22)
		maxLifePoints = 15 + getSkillMod(constitution)
		lifePoints = maxLifePoints
		enemyName = "Mage Orc"
	elif(enemyType == Goblin):
		strength = RandomNumber(10,16)
		dexterity = RandomNumber(18,24)
		intelligence = RandomNumber(8,12)
		constitution = RandomNumber(16,22)
		maxLifePoints = 16 + getSkillMod(constitution)
		lifePoints = maxLifePoints
		enemyName = "Goblin"
	if Hud != null:
		Hud.SetLv(enemyLevel)
		Hud.SetLifeBar(0,maxLifePoints)
		Hud.ChangeLifeBar(lifePoints)

func EnemyTurn():
	var decision = RandomNumber(0,10)
	var decisionAct
	if(decision >= 0 && decision <= 3):
		PassTurn()
	if(decision > 3 && decision <= 8):
		decisionAct = AttackHero()
	if(decision > 8):
		UseItem()

func PanelSpeak(text):
	var panel = get_parent().get_parent().get_node("PanelMenuEnemy")
	if !panel.is_visible():
		panel.show()
	panel.get_node("LabelName").set_text(enemyName)
	var labelText = panel.get_node("LabelText")
	labelText.set_text(text)

func UseItem():
	PassTurn()

func PassTurn():
	combatNode.ChangeTheTurnChar()
	pass

func AttackHero():
	var heros = get_tree().get_nodes_in_group("Hero")
	var target = RandomNumber(0, heros.size())
	PanelSpeak("Eu irei lhe atacar !")
	timeNode.set_wait_time(1.2)
	timeNode.set_one_shot(true)
	timeNode.start()
	yield(timeNode,"timeout")
	timeNode.stop()
	var damage = 1
	if enemyType == Goblin:
		damage += int(round(getSkillMod(dexterity) % 2))
	elif enemyType == Orc:
		damage += int(round(getSkillMod(strength)))
	elif enemyType == Mage_Orc:
		damage += int(round(getSkillMod(intelligence)))
	
	var speak = "Sinta esse lindo golpe seu %s de merda" % heros[target].get_name()
	PanelSpeak(speak)
	heros[target].TakeDamage(damage)
	timeNode.set_wait_time(1.5)
	timeNode.start()
	yield(timeNode,"timeout")
	PassTurn()

func TakeDamage(amount):
	var finalDamage = int(round(amount - (getSkillMod(constitution) * 0.8)))
	lifePoints -= finalDamage
	print("Levei de dano final %s de %s" % [finalDamage,amount])
	print("Tenho de vida agora: %s" % lifePoints)
	print("-------------")
	Hud.ChangeLifeBar(lifePoints)
	if(lifePoints <= 0):
		Die()

func Die():
	self.hide()

func RandomNumber(_min, _max):
	randomize()
	return (randi() % (_max - _min)) + _min 


func getSkillMod(Skill):
	return int(round((Skill - 10) /2))