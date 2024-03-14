extends "res://scenes/window.gd"


var femail = preload("res://scenes/windows/femail.tscn")

func _ready():
	super._ready()


func _on_not_login_pressed():
	_on_button_pressed()


func _on_login_pressed():
	var password = $Control/CenterContainer/VBoxContainer/TextEdit3.get_text()
	
	if password == "251234":
		var f = femail.instantiate()
		Global.windowsManager.add_window(f)
		
		_on_button_pressed()
	else:
		SoundPlayer.play("Fail2")


func _on_text_edit_3_text_submitted(new_text):
	_on_login_pressed()
