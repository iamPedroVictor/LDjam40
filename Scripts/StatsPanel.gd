extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var lifeLabel
var strengthLabel
var dexterityLabel
var intelligenceLabel
var constitutionLabel

const lifeTextTemplate = "Life: %s/%s"
const strengthTextTemplate = "Strength: %s"
const dexterityTextTemplate = "Dexterity: %s"
const intelligenceTextTemplate = "Intelligence: %s"
const constitutionTextTemplate = "Constitution: %s"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	lifeLabel = get_node("LifeLabel")
	strengthLabel = get_node("StrengthLabel")
	dexterityLabel = get_node("DexterityLabel")
	intelligenceLabel = get_node("IntelligenceLabel")
	constitutionLabel = get_node("ConstitutionLabel")
	pass
	
func Set_Stats(character):
	var characterParent = character.get_parent().get_name()
	print(characterParent)
	print(character.get_name())
	if(characterParent == "Heroes" or characterParent != "Enemies"):
		print("entrei")
		var lifepoints = character.lifePoints
		var maxLifePoints = character.maxLifePoints
		lifeLabel.set_text(lifeTextTemplate % [lifepoints, maxLifePoints])
		strengthLabel.set_text(strengthTextTemplate % character.strength)
		dexterityLabel.set_text(dexterityTextTemplate % character.dexterity)
		constitutionLabel.set_text(constitutionTextTemplate % character.constitution)
		intelligenceLabel.set_text(intelligenceTextTemplate % character.intelligence)
	pass

