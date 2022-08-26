extends Area2D

var player: QuiverCharacter = null

func player_is_in_range()->bool:
	return player != null

func get_player_position()->Vector2:
	if player_is_in_range():
		return player.global_position
	else:
		printerr("Error: PlayerDetector.get_player_position() -> player is not in range, returning Vector2.ZERO")
		return Vector2.ZERO

func _on_player_detector_body_entered(body):
	if body is QuiverCharacter:
		player = body


func _on_player_detector_body_exited(body):
	if body == player:
		player = null
