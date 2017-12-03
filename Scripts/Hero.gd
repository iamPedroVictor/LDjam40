extends Node2D

export(String) var nameHero = ""
export(int) var levelHero = 25
export(int) var xpHero = 1000
export(String, "Mage", "Warrior", "Marksman") var typeHero

var lifePoints = 0
var maxLifePoints = 0
var strength = 0
var dexterity = 0
var intelligence = 0
var constitution = 0

var heroName = ""

var anim
var Hud
var target
var combatNode

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	if Global.isHeroesAlready:
		print("Não preciso gerar mais um heroi")
	else:
		GenerateAttributes()
	anim = get_node("AnimationPlayer")
	anim.play("Idle")
	combatNode = get_tree().get_root().get_node("Combat")
	Hud = get_node("HUDBar")
	Hud.SetLifeBar(0, maxLifePoints)
	Hud.SetLv(levelHero)

func CalculateAttribute():
	if(typeHero == "Mage"):
		strength -= RandomNumber(1,2)
		dexterity -= RandomNumber(1,3)
		intelligence -= RandomNumber(1,2)
		constitution -= RandomNumber(1,3)
		maxLifePoints = 20 + getSkillMod(constitution)
	elif(typeHero == "Warrior"):
		strength -= RandomNumber(1,2)
		dexterity -= RandomNumber(1,3)
		intelligence -= RandomNumber(1,3)
		constitution -= RandomNumber(1,2)
		maxLifePoints = 35 + getSkillMod(constitution)
	elif(typeHero == "Marksman"):
		strength -= RandomNumber(1,3)
		dexterity -= RandomNumber(1,2)
		intelligence -= RandomNumber(1,2)
		constitution -= RandomNumber(1,3)
		maxLifePoints = 20 + getSkillMod(constitution)


func GenerateAttributes():
	heroName = typeHero
	if(typeHero == "Mage"):
		strength = RandomNumber(14,20)
		dexterity = RandomNumber(16,22)
		intelligence = RandomNumber(16,24)
		constitution = RandomNumber(14,18)
		maxLifePoints = 20 + getSkillMod(constitution)
	elif(typeHero == "Warrior"):
		strength = RandomNumber(16,22)
		dexterity = RandomNumber(14,20)
		intelligence = RandomNumber(14,18)
		constitution = RandomNumber(16,24)
		maxLifePoints = 35 + getSkillMod(constitution)
	elif(typeHero == "Marksman"):
		strength = RandomNumber(16,22)
		dexterity = RandomNumber(16,24)
		intelligence = RandomNumber(14,20)
		constitution = RandomNumber(14,18)
		maxLifePoints = 20 + getSkillMod(constitution)
	lifePoints = maxLifePoints

func LoseExp(amount):
	xpHero -= amount
	if xpHero <= 0:
		OnLoseLevel()

func AttackAction(_target):
	if(anim == null):
		return
	anim.play("Attack")
	target = _target

func Attack():
	var damage = 1
	if(typeHero == "Mage"):
		damage = 2 + getSkillMod(intelligence)
	elif(typeHero == "Warrior"):
		damage = 2 + getSkillMod(strength)
	elif(typeHero == "Marksman"):
		damage = 2 + getSkillMod(dexterity)
	target.TakeDamage(damage)
	combatNode.ChangeTheTurnChar()

func TakeDamage(amount):
	lifePoints -= amount
	Hud.ChangeLifeBar(lifePoints)
	if(lifePoints <= 0):
		Die()

func Die():
	print("morri")
	combatNode.HeroDie()
	self.hide()
	

func OnLoseLevel():
	levelHero-=1
	xpHero = 1000
	Hud.SetLv(levelHero)
	Hud.SetLifeBar(0, maxLifePoints)
	pass

func RandomNumber(_min, _max):
	randomize()
	return (randi() % (_max - _min)) + _min 

func getSkillMod(Skill):
	return int(round((Skill - 10) /2))