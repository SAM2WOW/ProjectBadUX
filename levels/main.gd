extends Node


func _input(event):
	if Input.is_action_just_pressed("ui_end"):
		get_tree().change_scene_to_file("res://levels/crashed.tscn")
