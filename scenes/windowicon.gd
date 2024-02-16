extends Button

@export var icon_texture : Texture2D
var window


func _ready():
	if "window_icon" in window:
		set_button_icon(window.window_icon)
	
	if "window_name" in window:
		set_tooltip_text(window.window_name)
	else:
		set_tooltip_text(window.name)


func _on_pressed():
	SoundPlayer.play("Confirm")
	
	window.popup()
	window.grab_focus()
