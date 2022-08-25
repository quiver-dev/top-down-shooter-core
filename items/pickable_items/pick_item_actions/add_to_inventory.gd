extends QuiverPickItemAction

# An example of QuiverPickItemAction that adds the pickable item's item to the inventory.
# Use this to create any simple pickable item.
# To define following actions (what happens if addind to inventory failed/succeeded),
# add child nodes OnFailure and OnSuccess and add any QuiverInteractableObjectAction script to those nodes

# The overrided pick_item function
func pick_item(pickable_item: QuiverPickableItem, character: QuiverCharacter):
	# next_action is used to trigger another action depending on the result of this one.
	var next_action = get_node_or_null("OnFailure")
	if character.can_grab_items:
		if character.inventory != null:
			var inventory = character.inventory
			if inventory.add_item(pickable_item.item):
				next_action = get_node_or_null("OnSuccess")
	
	if next_action is QuiverInteractableObjectAction:
		# Trigger next action
		next_action.trigger(pickable_item, character)
		
