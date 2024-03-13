extends Button

@export var icon_texture : Texture2D
@export var icon_name : String
@export var window : PackedScene


func _ready():
	set_button_icon(icon_texture)
	set_text(icon_name)


func _on_pressed():
	SoundPlayer.play("Confirm")
	
	var w = window.instantiate()
	
	# don't spawn if window already open, only focus
	if Global.windowsManager.does_window_exist(w.name):
		w.queue_free()
		return
	
	Global.windowsManager.add_window(w)
