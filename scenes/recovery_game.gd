extends Node2D

signal dead
signal win

var falling = false

func _physics_process(delta):
	if not falling:
		var mouse_pos = get_local_mouse_position()
		var clamp_x = clamp(mouse_pos.x, 11, 476)
		var clamp_y = clamp(mouse_pos.y, 19, 175)
		$CursorBody.set_position(Vector2(clamp_x, clamp_y))


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			SoundPlayer.play("Deny")
			
			falling = true
			$CursorBody.set_freeze_enabled(false)
			$CursorBody/Button.set_disabled(false)

func _on_dead_body_entered(body):
	if "Cursor" in body.name:
		falling = false
		$CursorBody.set_freeze_enabled(true)
		$CursorBody/Button.set_disabled(true)
		
		$CursorBody.set_position(Vector2.ZERO)
		$CursorBody.set_rotation(0)
		
		SoundPlayer.play("Fail2")
		
		emit_signal("dead")


func _on_win_body_entered(body):
	if "Cursor" in body.name:
		
		falling = false
		$CursorBody.set_freeze_enabled(true)
		$CursorBody/Button.set_disabled(true)
		
		$CursorBody.set_position(Vector2.ZERO)
		$CursorBody.set_rotation(0)
		
		emit_signal("win")


func _on_button_pressed():
	falling = false
	$CursorBody.set_freeze_enabled(true)
	$CursorBody/Button.set_disabled(true)
	
	$CursorBody.set_position(Vector2.ZERO)
	$CursorBody.set_rotation(0)
