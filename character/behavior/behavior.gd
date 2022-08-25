class_name QuiverCharacterBehavior
extends Node2D

# This define the structure for any Character Behavior
# extend this script to define you own Behavior

# This represents the character action (how the character is aiming, moving, shooting at a certain time)
# You can change this variable at runtime (in _physics_process) to create your own behavior
@onready var action := QuiverCharacterAction.new(Vector2.ZERO)

# Returns the current character action (aiming, movement, shooting)
func get_action() -> QuiverCharacterAction:
	return action


