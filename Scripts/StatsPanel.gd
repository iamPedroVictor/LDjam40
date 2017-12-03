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
	
	lifeLabel = get_node("GridContainer/LifeLabel")
	strengthLabel = get_node("GridContainer/StrengthLabel")
	dexterityLabel = get_node("GridContainer/DexterityLabel")
	intelligenceLabel = get_node("GridContainer/IntelligenceLabel")
	constitutionLabel = get_node("GridContainer/ConstitutionLabel")
	pass
	
func Set_Stats(character):
	var characterParent = character.get_parent().get_name()
	if(characterParent != "Heroes" or characterParent != "Enemies"):
		return
	else:
		lifeLabel.set_text(lifeTextTemplate % [character.lifePoint, character.maxLifePoint])
		strengthLabel.set_text(strengthTextTemplate % character.strength)
		dexterityLabel.set_text(dexterityTextTemplate % character.dexterity)
		constitutionLabel.set_text(constitutionTextTemplate % character.constitution)
		intelligenceLabel.set_text(intelligenceTextTemplate % character.intelligence)
	
	pass

