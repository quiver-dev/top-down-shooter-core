extends "res://top-down-shooter-core/gui/magazine_ui/magazine_ui.gd"

@onready var label = $Label

func _ready():
	super._ready()

func update_ui():
	label.text = "%d/%d" % [magazine.current_ammo, magazine.capacity]
