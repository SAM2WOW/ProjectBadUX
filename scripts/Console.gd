extends Node


var shortcut = preload("res://scenes/icon.tscn")

func _ready():
	Global.console = self


func crash_game():
	SoundPlayer.play("Crash")
	
	Global.console = null
	Global.windowsManager = null
	Global.healthBar = null
	Global.taskWindow = null
	Global.warningWindow = null
	
	if Global.subscriptions:
		for i in Global.subscriptions:
			i.queue_free()
		
		Global.subscriptions.clear();
	
	get_tree().change_scene_to_file("res://levels/crashed.tscn")


func install_app(texture,icon_name,window):
	var i = shortcut.instantiate()
	i.icon_texture = texture
	i.icon_name = icon_name
	i.window = window
	$"../Control/Icons/GridContainer".add_child(i)
