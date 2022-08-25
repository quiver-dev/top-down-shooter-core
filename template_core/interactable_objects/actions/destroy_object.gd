extends QuiverInteractableObjectAction

# A simple example of QuiverInteractableObjectAction that just instantly destroys the object

func trigger(object: QuiverInteractableObject, character: QuiverCharacter):
	object.queue_free()

