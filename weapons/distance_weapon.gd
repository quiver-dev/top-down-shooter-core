extends Node2D

# This covers the shooting weapons

@export var shoot_delay := 0.2 # Time between two bullets being shot

@export var bullet_scene : PackedScene

# The weapon magazine (don't forget to check local_to_scene if you want to instantiate the weapon multiple times)
@export var magazine : QuiverMagazine

@export var holder_character : NodePath

var shoot_direction = null

var _shoot_time := 0.0
var _reload_time := 0.0

@onready var bullet_spawn_point := $BulletSpawnPoint
@onready var character = get_node(holder_character)

func _ready():
	if magazine != null:
		magazine.reload() # TEMP 

func _process(delta):
	_shoot_time += delta


func shoot():
	if _shoot_time < shoot_delay:
		return	
	_shoot_time = 0.0
	
	if magazine != null:
		if magazine.current_ammo <= 0:
			return
		magazine.shoot()
	
	# Instance a bullet
	var bullet : QuiverBullet = bullet_scene.instantiate()
#	bullet.top_level = true # Independent movement from weapon/player
	
	
	if magazine != null and magazine.auto_refill:
		bullet.bullet_destroyed.connect(self.bullet_destroyed)
	
	character.add_sibling(bullet)
	bullet.global_transform = bullet_spawn_point.global_transform
	bullet.init(shoot_direction)
	
func bullet_destroyed():
	magazine.current_ammo += 1


