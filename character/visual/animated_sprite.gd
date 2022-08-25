extends QuiverCharacterVisual

# This is a Visual meant to be used with an AnimatedSprite2D node
# The animations should be named "0" "1" "2"... each animation coresponding to a rotation of the character
# The animation "0" should be the enemy facing right
# The next animations represents the character rotated in clockwise order

enum RotationMode {NONE, AIMING, MOVING}

# Will the character rotate on aiming or moving ?
@export var rotation_mode : RotationMode = RotationMode.AIMING

# How many different angles do you want your character to rotate
# You will need to have a walking animation for each angle
@export var rotation_clamping := 4

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func update_visual(action: QuiverCharacterAction):
	
	if action.moving_direction.length() > 0:
		animated_sprite.play()
	else:
		animated_sprite.stop()
		animated_sprite.frame = 0 # The standing/idle frame
	
	
	if rotation_mode == RotationMode.AIMING and action.aiming_direction.length() > 0:
		_apply_animated_sprite_rotation(action.aiming_direction.angle())
	elif rotation_mode == RotationMode.MOVING and action.moving_direction.length() > 0:
		_apply_animated_sprite_rotation(action.moving_direction.angle())
	


func _apply_animated_sprite_rotation(angle):
	var k = int(round(angle/(2*PI/rotation_clamping)))
	k = (k+rotation_clamping)%rotation_clamping
	animated_sprite.animation = str(k)
