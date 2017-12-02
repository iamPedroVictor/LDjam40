extends Node2D

export(String) var nameHero = ""
export(int) var levelHero = 25
export(int) var xpHero = 1000
export(String, "Mage", "Warrior", "Ranger") var typeHero

var lifePoints = 0
var maxLifePoints = 0
var strength = 0
var dexterity = 0
var intelligence = 0
var constitution = 0



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func GenerateAttributes():
	if(typeHero == "Mage"):
		strength = RandomNumber(14,20)
		dexterity = RandomNumber(16,22)
		intelligence = RandomNumber(16,24)
		constitution = RandomNumber(14,18)
		maxLifePoints = 9 + getSkillMod(constitution)
	elif(typeHero == "Warrior"):
		strength = RandomNumber(16,22)
		dexterity = RandomNumber(14,20)
		intelligence = RandomNumber(14,18)
		constitution = RandomNumber(16,24)
		maxLifePoints = 9 + getSkillMod(constitution)
	elif(typeHero == "Ranger"):
		strength = RandomNumber(16,22)
		dexterity = RandomNumber(16,24)
		intelligence = RandomNumber(14,20)
		constitution = RandomNumber(14,18)
		maxLifePoints = 9 + getSkillMod(constitution)

func LoseExp(amount):
	xpHero -= amount
	if xpHero <= 0:
		levelHero-=1
		OnLoseLevel()

func Attack(target):
	pass

func OnLoseLevel():
	pass

func RandomNumber(_min, _max):
	randomize()
	return (randi() % (_max - _min)) + _min 

func getSkillMod(Skill):
	return int(round((Skill - 10) /2))