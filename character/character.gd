extends CharacterBody2D
class_name QuiverCharacter
# Default Character

enum RotationType {NONE, AIMING, MOVING}

@export var character_stats: QuiverCharacterStats
@export var inventory: QuiverInventory

@export var physics_stats: QuiverPhysicsStats

# Wil rotate the entire CharacterBody2D towards the aiming/moving direction
@export var rotate_body_towards : RotationType = RotationType.NONE

# Can grab items
@export var can_grab_items := true



@onready var visual : QuiverCharacterVisual = $Visual
@onready var behavior : QuiverCharacterBehavior = $Behavior


var _impulse := Vector2.ZERO

# Emitted when the behavior asks to shoot
# Connect this signal to the current weapon shoot function
signal shoot

func _ready():
	character_stats.set_life_to_max()
	
	if !(visual is QuiverCharacterVisual):
		printerr("Error: Visual node is not a QuiverCharacterVisual (add the corresponding script)")
	if !(behavior is QuiverCharacterBehavior):
		printerr("Error: Behavior node is not a QuiverCharacterBehavior (add the corresponding script)")
	
	behavior.physics_stats = physics_stats

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
		velocity = velocity.lerp(action.moving_direction*physics_stats.max_speed, physics_stats.acceleration)
	else: # Apply Friction
		velocity = velocity.lerp(Vector2.ZERO, physics_stats.friction)
	move_and_slide()
	
	# Character visual update
	visual.update_visual_and_state(action)
	
	# Detect and handle collisions
	for i in get_slide_collision_count():
		behavior.handle_collision(get_slide_collision(i))
		
	
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
	_impulse = from*physics_stats.impulse_force

func die():
	queue_free()

