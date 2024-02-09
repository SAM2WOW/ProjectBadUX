extends Node


func _ready():
	
	await get_tree().create_timer(1).timeout
	
	$Control/ColorRect.set_color(Color("#0000a5"))
	
	await get_tree().create_timer(0.2).timeout
	
	$Control/CenterContainer.show()
