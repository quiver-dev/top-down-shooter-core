extends Resource
class_name QuiverItem

# This Resource type defines an item.
# You can extend it to add details to your items.

@export var name: String
@export var short_description: String
@export var long_description: String
@export var ui_icon: Texture
@export var stackable: bool
@export var stack_size: int # <= 0 means infinity

# A QuiverItemUseAction resource, defines what will happen when the item will be used
@export var use_action: QuiverItemUseAction

# Link to the corresponding pickable item scene, if you need to drop the item back on the floor
@export_file("*.tscn") var pickable_item_scene

var _pickable_item_scene: PackedScene


# This function is called when the item is used by a character
# Do not override it, to create new use behaviors, please see use_action
func use(user: QuiverCharacter)->bool:
	if use_action is QuiverItemUseAction:
		return use_action.use(user)
	else:
		return false


# A function to instantiate the pickable item scene corresponding to this item
# Call this to drop the item back on the floor
func create_pickable_item():
	if _pickable_item_scene == null:
		if pickable_item_scene != null:
			_pickable_item_scene = load(pickable_item_scene)
	var pickable_item = null
	if _pickable_item_scene != null:
		pickable_item = _pickable_item_scene.instantiate()
	return pickable_item
