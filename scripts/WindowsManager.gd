extends Node


var opened_windows = {}

var icon_btn = preload("res://scenes/windowicon.tscn")


func _ready():
	Global.windowsManager = self


func does_window_exist(window_name):
	if window_name in opened_windows.keys():
		# auto focus new window
		opened_windows[window_name].window.popup()
		opened_windows[window_name].window.grab_focus()
		
		return true
	else:
		return false


func add_window(window):
	$"../Windows".add_child(window)
	
	var b = icon_btn.instantiate()
	b.window = window
	$"../Taskbar/HBoxContainer".add_child(b)
	
	opened_windows[window.name] = b
	
	# remove other focus
	
	
	# auto focus new window
	window.popup_centered()
	window.grab_focus()
	
	window.set_position(Vector2i(120, 20) + Vector2i(120, 0) * (b.get_index() / 8) + Vector2i(40, 40) * (b.get_index() % 8))


func remove_window(window):
	opened_windows[window.name].queue_free()
	
	opened_windows.erase(window.name)
