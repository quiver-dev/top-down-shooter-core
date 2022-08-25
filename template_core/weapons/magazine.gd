class_name QuiverMagazine
extends Resource

# This is the Magazine of any shooting weapon

# Emited when the magazine state changed
signal magazine_changed

# This is the maximum number of ammo you can store in the magazine (<=0 means infinite)
@export var capacity := 1 :
	set(value):
		capacity = value
		magazine_changed.emit()

# Reloading time (#TODO)
@export var reload_time := 0.0

# If checked, when a bullet is being destroyed, it will be added back to the magazine automaticaly
@export var auto_refill := false

# Current ammo left in the magazine
var current_ammo := 0 :
	set(value):
		current_ammo = value
		magazine_changed.emit()

# set current ammo to the magazine capacity
func reload()->void:
	current_ammo = capacity
	magazine_changed.emit()

# consume an ammo, if no more ammo, return false
func shoot()->bool:
	if current_ammo <= 0:
		return false
	if capacity <= 0: # Infininte magazine
		magazine_changed.emit()
		return true
	
	current_ammo -= 1
	magazine_changed.emit()
	return true
