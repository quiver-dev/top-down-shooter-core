extends Node2D
class_name QuiverInteractMechanic

# This defines the QuiverInteractableObject interact mechanic.
# Please do not modify this script.
# If needed, you can create your own type of QuiverInteractMechanic by extending this script.

# Emited when a character interacts with the object.
signal interacted(character)


# Call this function in your extending script to trigger the object's action.
func interact(character: QuiverCharacter):
	interacted.emit(character)
