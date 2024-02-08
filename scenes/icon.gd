extends Button

@export var icon_texture : Texture2D
@export var icon_name : String
@export var window : PackedScene


func _ready():
	set_button_icon(icon_texture)
	set_text(icon_name)

func _on_pressed():
	var w = window.instantiate()
	add_child(w)
	
	WindowsManager.add_window(w)
