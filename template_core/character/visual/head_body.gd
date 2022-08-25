extends QuiverCharacterVisual

# This Visual allows to rotate a head based on the aiming direction
# It is useful when combined with the rotate_body_towards option from Character set to Movement

@onready var head : Node2D = $Head

func update_visual(action: QuiverCharacterAction):
	head.global_rotation = action.aiming_direction.angle()
