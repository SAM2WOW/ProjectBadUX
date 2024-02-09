extends Button

@export var icon_texture : Texture2D
var window


func _ready():
	set_button_icon(window.window_icon)
	set_tooltip_text(window.window_name)


func _on_pressed():
	window.popup()
	window.grab_focus()
