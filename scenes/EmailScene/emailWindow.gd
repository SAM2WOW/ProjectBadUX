extends "res://scenes/window.gd"


var femail = preload("res://scenes/windows/femail.tscn")

func _ready():
	super._ready()


func _on_not_login_pressed():
	_on_button_pressed()


func _on_login_pressed():
	var f = femail.instantiate()
	Global.windowsManager.add_window(f)
	
	_on_button_pressed()
