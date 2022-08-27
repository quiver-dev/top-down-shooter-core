class_name QuiverCharacterVisual
extends Node2D

# This define the structure for any Character Visual System
# extend this script to define you own Visual System

# The current state of the character
var current_state := ""

# Override this function to change the character visuals depending on the character action
# This will be called automaticly, you only need to define your rules so the character show up corectly 
func update_visual(action: QuiverCharacterAction)->void:
	pass

# A function to override if you want to change the enemy visual when it's state changes 
func on_state_changed(new_state: String)->void:
	pass


# Core Fuctions: DO NOT OVERRIDE, DO NOT MODIFY
func update_visual_and_state(action: QuiverCharacterAction)->void:
	update_visual(action)
	if action.state_name != current_state:
		current_state = action.state_name
		on_state_changed(current_state)
