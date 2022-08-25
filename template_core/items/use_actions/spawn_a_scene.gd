extends QuiverItemUseAction
class_name QuiverItemUseSpawnAScene

# An example of QuiverItemUseAction that spawns a scene at the character position.

# The scene to spawn
@export var scene_to_spawn: PackedScene


# Defines what will happen when a character uses the item.
func use(user: QuiverCharacter)->bool:
	var node = scene_to_spawn.instantiate()
	# Place the item at the user position
	node.position = user.position
	user.add_sibling(node)
	return true

