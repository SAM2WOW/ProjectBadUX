extends "res://scenes/window.gd"


func _ready():
	super._ready()


func _on_archive_pressed():
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/TabContainer.set_current_tab(1)


func _on_inbox_pressed():
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/TabContainer.set_current_tab(0)
