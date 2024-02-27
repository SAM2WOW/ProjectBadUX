extends Node2D


func _ready():
	$Timer.start(randf_range(1.0, 4.0))


func _on_timer_timeout():
	
	
	$Timer.start(randf_range(1.0, 4.0))


func move():
	pass
