extends Node


func _on_texture_button_pressed():
	SoundPlayer.play("Success")
	get_tree().change_scene_to_file("res://levels/main.tscn")
