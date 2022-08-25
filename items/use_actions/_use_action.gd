extends Resource
class_name QuiverItemUseAction

# This defines the QuiverItem action.
# Please do not modify this script.
# If needed, you can create your own type of QuiverItemUseAction by extending this script.


# Defines what will happen when a character uses the item.
# Returns false if the action cannot be done at the moment.
func use(user: QuiverCharacter)->bool:
	printerr("Item use is not overrided in ", self.script.resource_path)
	return false
