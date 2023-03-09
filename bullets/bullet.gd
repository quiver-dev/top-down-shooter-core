extends RigidBody2D
class_name QuiverBullet

@export var speed := 1500.0 # Bullet speed
@export var life_time := 0.0 # Destroy after some time (<=0 means infinite)
@export var max_bounce := 0 # The number of time the bullet can bounce (negative value means infinite bouces)

@export var damage := 1.0

@export var impact_scene : PackedScene # The impact scene displayed on impact

var _velocity: Vector2
var _t := 0.0
var _bounce_count := 0

signal bullet_destroyed # Emitted when the bullet is destroyed

func _ready():
	self.tree_exited.connect(_on_tree_exited)


func init(shoot_direction):
	if shoot_direction != null:
		_velocity = speed*shoot_direction
	else:
		_velocity = global_transform.x * speed


func _physics_process(delta):
	var collision := move_and_collide(_velocity*delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("hit"):
			collider.hit(damage, (collider.global_position - global_position).normalized())
			
			
			
			place_impact(collider, collision.get_normal())
			self.queue_free()
			return
		
		_bounce_count += 1
		
		place_impact(collider, collision.get_normal())
		
		if max_bounce >= 0 and _bounce_count > max_bounce:
			self.queue_free()
		else:
			_velocity = _velocity.bounce(collision.get_normal())
		rotation = _velocity.angle()
	_t += delta
	if life_time > 0.0 and _t >= life_time:
		self.queue_free()


func place_impact(collider, normal):
	if impact_scene == null: return
	var impact : Node2D = impact_scene.instantiate()
	collider.add_child(impact)
	impact.global_transform = global_transform
	impact.global_rotation = normal.angle()

func _on_tree_exited():
	bullet_destroyed.emit()
