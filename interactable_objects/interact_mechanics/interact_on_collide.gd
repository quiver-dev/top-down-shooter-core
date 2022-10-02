extends QuiverInteractMechanic

# An example of QuiverInteractMechanic that triggers when a character collide with the object's body

# The path to the body of the object (should be a RigidBody2D)
@export var object_body_path : NodePath

# Hold the body node
var _object_body : RigidBody2D


func _ready():
	var node = get_node(object_body_path)
	if node is RigidBody2D:
		_object_body = node

		# This is to make sure the contact with the character will be reported
		_object_body.contact_monitor = true
		_object_body.max_contacts_reported = 1
 
		_object_body.body_entered.connect(self._body_entered)
		
	else:
		printerr("interact_on_collide: rigidbody_path doesn't give access to a RigidDynamicBody node")

func _body_entered(body):
	if body is QuiverCharacter:
		# We trigger the action every time, the QuiverInteractableObjectAction will take care of handling if the corresponding character can interact
		interact(body)
