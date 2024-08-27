extends Node

var can_skip = false


func _ready():
	var new_text = "[center][b][ Your PC CRASHED ][/b] [/center]
 
 
 
---------------------------------------
|                                                                     |
| You have fell for the [wave amp=50.0 freq=5.0 connected=1]UX DARK PATTERNS[/wave]  |
|                                                                     |
---------------------------------------
%s
 
 
[center][b]Press any key to continue...[/b] [/center]"
	$Control/CenterContainer/Label.set_text(new_text % Global.crash_reason)
	
	
	await get_tree().create_timer(1).timeout
	
	$Control/ColorRect.set_color(Color("#0000a5"))
	
	await get_tree().create_timer(0.2).timeout
	
	$Control/CenterContainer.show()
	can_skip = true


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if event.pressed:
			SoundPlayer.play("Success")
			get_tree().change_scene_to_file("res://levels/main.tscn")
