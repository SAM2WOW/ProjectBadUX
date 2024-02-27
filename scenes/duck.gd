extends Node2D

signal duck_out
signal duck_kill

var velocity

var bad = false


func _process(delta):
	$Duck.rotate(0.01)
	
	move_local_y(delta * -150)
	
	if position.y < 0.0:
		emit_signal("duck_out")
		queue_free()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("DUck")


func _on_area_2d_mouse_entered():
	$Duck.set_scale(Vector2(0.1, 0.1))


func _on_area_2d_mouse_exited():
	$Duck.set_scale(Vector2(0.045, 0.045))
