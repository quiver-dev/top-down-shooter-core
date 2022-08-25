extends CharacterBody2D
class_name QuiverCharacter
# Default Character

enum RotationType {NONE, AIMING, MOVING}

@export var character_stats: Resource # Type should be QuiverLifeStats
@export var inventory: Resource # Type should be QuiverInventory

@export var max_speed := 500.0
@export var acceleration := 0.4
@export var friction := 0.1

# The impulse force applied when the character is hit (zero means no impulse)
@export var impulse_force := 0.0

# Wil rotate the entire CharacterBody2D towards the aiming/moving direction
@export var rotate_body_towards : RotationType = RotationType.NONE

# Can grab items
@export var can_grab_items := true



@onready var visual : QuiverCharacterVisual = $Visual
@onready var behavior : QuiverCharacterBehavior = $Behavior


var _impulse := Vector2.ZERO

# Emited when the behavior asks to shoot
# Connect this signal to the current weapon shoot function
signal shoot

func _ready():
	character_stats.set_life_to_max()
	
	if !(visual is QuiverCharacterVisual):
		printerr("Error: Visual node is not a QuiverCharacterVisual (add the corresponding script)")
	if !(behavior is QuiverCharacterBehavior):
		printerr("Error: Behavior node is not a QuiverCharacterBehavior (add the corresponding script)")
	

func _physics_process(delta):
	var action : QuiverCharacterAction = behavior.get_action()
	
	
	# Character rotation
	match rotate_body_towards:
		RotationType.MOVING:
			if action.moving_direction != Vector2.ZERO:
				rotation = action.moving_direction.angle()
		RotationType.AIMING:
			rotation = action.aiming_direction.angle()
	
	# Character Movement
	if action.moving_direction.length() > 0: # Accelerate
		velocity = velocity.lerp(action.moving_direction*max_speed, acceleration)
	else: # Apply Friction
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	# Character visual update
	visual.update_visual(action)
	
	# Shooting
	if action.shoot:
		action.shoot = false
		emit_signal("shoot")
	
	# Apply Impulse
	if _impulse.length() > 0:
		velocity = _impulse
		_impulse /= 1.2
		if _impulse.length() < 1.0:
			_impulse = Vector2.ZERO

func hit(damage:=1, from:=Vector2.ZERO):
	character_stats.damage(damage)
	if character_stats.current_life == 0:
		die()
	_impulse = from*impulse_force

func die():
	queue_free()
