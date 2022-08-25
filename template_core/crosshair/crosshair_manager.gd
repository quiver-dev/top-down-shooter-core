extends Node

@export var default_crosshair : Texture

func _ready():
	set_crosshair(default_crosshair)

func set_crosshair(texture):
	Input.set_custom_mouse_cursor(texture, 0 , Vector2(11,11))


func _exit_tree():
	Input.set_custom_mouse_cursor(null,Input.CURSOR_ARROW)
