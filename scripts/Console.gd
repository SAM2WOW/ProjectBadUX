extends Node


func _ready():
	Global.console = self


func crash_game():
	get_tree().change_scene_to_file("res://levels/crashed.tscn")
	SoundPlayer.play("Crash")
