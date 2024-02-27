extends Node


var opened_windows = {}

var icon_btn = preload("res://scenes/windowicon.tscn")

func _ready():
	Global.windowsManager = self


func add_window(window):
	$"../Windows".add_child(window)
	
	var b = icon_btn.instantiate()
	b.window = window
	$"../CanvasLayer/Control/Taskbar/HBoxContainer".add_child(b)
	
	opened_windows[window.name] = b
	
	# remove other focus
	
	
	# auto focus new window
	window.popup_centered()
	window.grab_focus()
	
	window.set_position(Vector2i(120, 20) + Vector2i(40, 40) * opened_windows.size())


func remove_window(window):
	opened_windows[window.name].queue_free()
	
	opened_windows.erase(window.name)
