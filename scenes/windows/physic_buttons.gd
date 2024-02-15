extends "res://scenes/window.gd"


func _physics_process(delta):
	$Node2D/CursorBody.set_position(get_mouse_position())
