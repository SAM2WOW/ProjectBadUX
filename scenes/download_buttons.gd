extends Node2D

var target
var moving = false
var speed = 50

var hovering = false

var bad = false

signal selected

func _ready():
	#$Timer.start(randf_range(1.0, 4.0))
	
	$TextureButton.set_texture_normal(load("res://arts/downloads/DownloadBtn (%d).png" % randi_range(1, 4)))
	
	if bad:
		$TextureButton.set_default_cursor_shape(0)
	
	self.modulate = Color.from_hsv((randi() % 12) / 12.0, 1, 1)


func _on_timer_timeout():
	target = Vector2(-50 + (600 * (randi() % 2)), randf_range(12, 500))
	moving = true
	$AnimationPlayer.play("Walking")


func _process(delta):
	#speed = lerpf(speed, 50 + 80 * int(hovering), delta * 25)
	speed = 150
	
	$AnimationPlayer.set_speed_scale(speed / 20)
	
	if moving:
		position.x = move_toward(position.x, target.x, delta * speed)
		position.y = move_toward(position.y, target.y, delta * speed)
		
		if position.distance_to(target) < 10:
			moving = false
			#$Timer.start(randf_range(1.0, 4.0))
			
			$AnimationPlayer.play("nothing")


func _on_texture_button_mouse_entered():
	hovering = true
	
	$TextureButton.set_scale(Vector2(1.1, 1.1))


func _on_texture_button_mouse_exited():
	hovering = false
	
	$TextureButton.set_scale(Vector2(1, 1))


func _on_texture_button_pressed():
	emit_signal("selected")


func _on_texture_button_button_down():
	if bad:
		target = Vector2(-160 + (800 * (randi() % 2)), randf_range(12, 500))
		moving = true
		$AnimationPlayer.play("Walking")
		
		$AudioStreamPlayer.play()
		
		Global.healthBar.take_damage(5)
