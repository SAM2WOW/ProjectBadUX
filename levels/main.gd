extends Node


func _ready():
	await get_tree().create_timer(0.3).timeout
	$CanvasLayer.show()
	await get_tree().create_timer(0.2).timeout
	$Control/Icons.show()
	
	$CanvasLayer/Control/Taskbar/TaskList.show_window()


func _input(event):
	if Input.is_action_just_pressed("ui_end"):
		Global.console.crash_game()
