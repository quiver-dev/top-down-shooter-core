extends Area2D

# Create any melee weapon with custom shapes

@export var damage := 0.0

func _on_melee_weapon_body_entered(body: Node2D):
	if body.has_method("hit"):
		body.hit(damage)
