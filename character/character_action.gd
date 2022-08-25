class_name QuiverCharacterAction
extends Object

# This is a custom type to cover any character action

# If the character is trying to shoot
var shoot := false

# The character moving direction
var moving_direction := Vector2.ZERO:
	set(value):
		moving_direction = value.normalized()

# The character aiming direction
var aiming_direction := Vector2.ZERO:
	set(value):
		aiming_direction = value.normalized()

func _init(moving_direction : Vector2, aiming_direction := Vector2.ZERO, shoot := false):
	self.moving_direction = moving_direction
	self.aiming_direction = aiming_direction
	self.shoot = shoot
