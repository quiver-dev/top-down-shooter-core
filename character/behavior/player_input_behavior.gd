extends QuiverCharacterBehavior

# returns the player input movement direction
func _get_moving_input()->Vector2:
	return Input.get_vector("player_left", "player_right", "player_up", "player_down")

# returns the player input aiming direction
func _get_aiming_input()->Vector2:
	return global_position.direction_to(get_global_mouse_position())


func _physics_process(delta):
	action.moving_direction = _get_moving_input()
	action.aiming_direction = _get_aiming_input()

# set the input shoot to true when "fire" is pressed
func _input(event): # Should be unhandled input, but sub viewports don't receive unhandled inputs yet, see https://github.com/godotengine/godot/issues/17326
	if event.is_action_pressed("fire"):
		action.shoot = true
