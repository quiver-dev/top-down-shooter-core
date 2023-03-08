class_name QuiverCharacterBehavior
extends Node2D

# This define the structure for any Character Behavior
# extend this script to define you own Behavior

# This represents the character action (how the character is aiming, moving, shooting at a certain time)
# You can change this variable at runtime (in _physics_process) to create your own behavior
@onready var action := QuiverCharacterAction.new(Vector2.ZERO)

# The character's physics stats, so the behavior can change max_speed and other parameters.
var physics_stats: QuiverPhysicsStats

# Returns the current character action (aiming, movement, shooting)
func get_action() -> QuiverCharacterAction:
	return action

# Override this function to make advanced collision handling
# Otherwise, you can override on_..._collision functions 
func handle_collision(collision: KinematicCollision2D)->void:
	const LAYER_WORLD = 1
	const LAYER_PLAYER = 2
	const LAYER_ENEMIES = 4
	const LAYER_WALLS = 7
	
	var collider = collision.get_collider()
	
	# There is currently no way to know the tile type, or retreive any data
	# See this issue https://github.com/godotengine/godot/issues/65009
	if collider is TileMap:
		return
	
	if collider is CollisionObject2D:
		if collider.get_collision_layer_value(LAYER_WORLD) or collider.get_collision_layer_value(LAYER_WALLS):
			on_wall_collision(collision)
		if collider.get_collision_layer_value(LAYER_PLAYER):
			on_player_collision(collision)
		if collider.get_collision_layer_value(LAYER_ENEMIES):
			on_enemy_collision(collision)
	
# Override this to define a behavoir when colliding with a wall
func on_wall_collision(collision: KinematicCollision2D)->void:
	pass

# Override this to define a behavoir when colliding with an enemy
func on_enemy_collision(collision: KinematicCollision2D)->void:
	pass

# Override this to define a behavoir when colliding with a player
func on_player_collision(collision: KinematicCollision2D)-> void:
	pass
