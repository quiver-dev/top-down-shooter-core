extends "res://top-down-shooter-core/gui/player_ui/player_ui.gd"

@onready var label = $Label

func _ready():
	super._ready()

func update_ui():
	label.text = "%d/%d" % [player_stats.current_life, player_stats.max_life]
