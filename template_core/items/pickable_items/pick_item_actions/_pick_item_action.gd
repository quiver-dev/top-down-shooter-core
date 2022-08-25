extends QuiverInteractableObjectAction
class_name QuiverPickItemAction

# This defines the QuiverPickableItem action.
# Please do not modify this script.
# If needed, you can create your own type of QuiverPickItemAction by extending this script.

# Will be called by the pickable item when being interacted.
# DO NOT OVERRIDE to define your behavior, override pick_item
func trigger(object: QuiverInteractableObject, character: QuiverCharacter):
	if object is QuiverPickableItem:
		pick_item(object, character)


# Defines what happens when the item is picked (= object interracted)
func pick_item(pickable_item: QuiverPickableItem, character: QuiverCharacter):
	pass
