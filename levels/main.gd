extends Node


func _ready():
	# f u
	$Taskbar.position = Vector2i(0, 680)
	
	await get_tree().create_timer(0.3).timeout
	$CanvasLayer.show()
	$Taskbar/TaskList.show_window()
	
	await get_tree().create_timer(0.4).timeout
	$Control/Icons.show()
	


func _input(event):
	if Input.is_action_just_pressed("ui_end"):
		Global.console.crash_game()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
