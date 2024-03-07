extends "res://scenes/window.gd"


func _on_control_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			$Quack.play()
			
			#$Control/TextureRect.set_rotation_degrees($Control/TextureRect.get_rotation_degrees() + 90)
