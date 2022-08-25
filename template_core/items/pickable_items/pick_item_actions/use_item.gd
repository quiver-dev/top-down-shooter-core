extends QuiverPickItemAction

# An example of QuiverPickItemAction that instantly use the picked item the pickable item's item to the inventory.
# Use this to create any simple pickable item.

# The overrided pick_item function
func pick_item(pickable_item: QuiverPickableItem, character: QuiverCharacter):
	var next_action = get_node_or_null("OnFailure")
	if character.can_grab_items:
		if pickable_item.item.use(character):
			next_action = get_node_or_null("OnSuccess")
	
	if next_action is QuiverInteractableObjectAction:
		next_action.trigger(pickable_item, character)
