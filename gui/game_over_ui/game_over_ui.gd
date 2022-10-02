extends Control

# Emited if the player wants to restart the game
signal restart

@export var player_stats : QuiverPlayerStats

func _ready():
	if player_stats is QuiverCharacterStats:
		player_stats.died.connect(self.show_game_over)


func show_game_over():
	visible = true
	get_tree().paused = true
	
	
func hide_game_over():
	visible = false
	restart.emit()
	get_tree().paused = false
