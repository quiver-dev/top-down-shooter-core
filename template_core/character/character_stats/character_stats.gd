class_name QuiverCharacterStats
extends Resource

# This resource is meant to give each character its stats
# You can use it to share your player character stats with the UI
# /!\ Don't forget to  set local to scene on if you want to instantiate different characters with the same TemplateCharacterStats resources

# emited when the character is supposed to die (no more life)
signal died
# emited when one of the character stats has changed
signal stats_changed

# the current max life of the character (should be greater than zero
@export_range(1,100) var max_life := 5:
	set(value):
		max_life = value
		if current_life > max_life:
			current_life = max_life
		stats_changed.emit()

# the current character life
var current_life := 5:
	set(value):
		current_life = max_life if value >= max_life else value
		if current_life <= 0:
			current_life = 0
			died.emit()
		stats_changed.emit()

# set current life to be equal to max life
func set_life_to_max():
	current_life = max_life

func damage(amount:int):
	current_life -= amount
