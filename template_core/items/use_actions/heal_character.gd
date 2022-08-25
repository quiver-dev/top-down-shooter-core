extends QuiverItemUseAction
class_name QuiverItemUseActionHealCharacter

# An example of QuiverItemUseAction that heals the character when the item is used.
# Use this to create potions and healing items.

enum HealingType {HEALTH, SHIELD}

# The item can add health or shield points.
@export var healing_type : HealingType

# The amount of points added when the item is used.
@export var healing_power := 1

# Defines what will happen when a character uses the item.
# Returns false if the character is already full health.
func use(user: QuiverCharacter)->bool:
	if user.character_stats != null:
		var stats = user.character_stats as QuiverCharacterStats
		if healing_type == HealingType.HEALTH:
			if stats.current_life < stats.max_life:
				stats.current_life += healing_power
				return true
		elif healing_type == HealingType.SHIELD:
			if "current_shield" in stats:
				stats.current_shield += healing_power
				return true
	return false

