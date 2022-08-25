@tool
extends Node2D
class_name QuiverInteractableObject

# Interactable Object: Any object that a character can interact with (doors, chests ...)
# /!\ If you can pick up the object, consider using QuiverPickableItem instead.

# The object's action: what will it do when a character interacts with it
@onready var action: QuiverInteractableObjectAction = $Action
# The interact mechanic: how a character can interact with this object
@onready var interact_mechanic: QuiverInteractMechanic = $InteractMechanic 

func _ready():
	if interact_mechanic is QuiverInteractMechanic:
		interact_mechanic.interacted.connect(self.trigger_action)
	
	# Setting up editor warnings
	if Engine.is_editor_hint():
		$GrabAction.script_changed.connect(self.update_configuration_warnings)
		$UseAction.script_changed.connect(self.update_configuration_warnings)
		update_configuration_warnings()


# Transmit the triggering from the mechanic to trigger the action
func trigger_action(character: QuiverCharacter):
	action.trigger(self, character)


func _get_configuration_warnings():
	var warnings = []
	if not $Action is QuiverInteractableObjectAction:
		warnings.append("Add a QuiverInteractableObjectAction script to $Action")
	if not $InteractMechanic is QuiverInteractMechanic:
		warnings.append("Add a QuiverInteractMechanic script to $InteractMechanic")
#	if not item is QuiverItem:
#		warnings.append("item from PickableItem should be of type QuiverItem")
	return warnings
