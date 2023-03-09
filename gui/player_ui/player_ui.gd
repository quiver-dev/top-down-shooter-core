extends Control

@export var player_stats : Resource # Type should be QuiverPlayerStats

func _ready():
	if player_stats is QuiverCharacterStats:
		player_stats.stats_changed.connect(self.update_ui)
		update_ui()

# Override this function to make your own UI
func update_ui():
	print("PlayerStats: %d/%d" % [player_stats.current_life, player_stats.max_life])
