extends Node2D

signal duck_out
signal duck_kill

var velocity
var direction = 1
var speed

var bad = false
var hovering = false

func _ready():
	randomize()
	
	speed = randf_range(0.5, 1.0)
	
	if randi() % 2:
		direction = -1
	
	if randi() % 2:
		bad = true
		
		$Sprites/Duck2.set_texture(load("res://arts/ducks/aiduck (%d).png" % randi_range(1, 5)))
		
		$Sprites/Duck.hide()
		$Sprites/Duck2.show()


func _process(delta):
	var new_size = lerpf($Sprites.scale.x, 1 + 0.1 * int(hovering), delta * 50)
	$Sprites.set_scale(Vector2(new_size, new_size))
		
	#$Sprites.rotate(0.01 * direction)
	
	move_local_y(delta * (-200 * speed))
	
	move_local_x(delta * 80 * direction * speed)
	
	if position.y < 0.0:
		emit_signal("duck_out")
		queue_free()
	
	if get_local_mouse_position().length() < 50:
		_on_area_2d_mouse_entered()
	else:
		_on_area_2d_mouse_exited()


func kill():
	emit_signal("duck_kill")
	queue_free()
	
	if not bad:
		Global.healthBar.take_damage(5)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("DUck")


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if hovering:
				kill()


func _on_area_2d_mouse_entered():
	
	hovering = true


func _on_area_2d_mouse_exited():
	$Sprites.set_scale(Vector2(1, 1))
	hovering = false
