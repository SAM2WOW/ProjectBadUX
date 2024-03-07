extends Node

var can_skip = false


func _ready():
	
	await get_tree().create_timer(1).timeout
	
	$Control/ColorRect.set_color(Color("#0000a5"))
	
	await get_tree().create_timer(0.2).timeout
	
	$Control/CenterContainer.show()
	can_skip = true


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene_to_file("res://levels/main.tscn")
