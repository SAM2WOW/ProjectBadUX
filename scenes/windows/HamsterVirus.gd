extends "res://scenes/window.gd"


func _on_close_requested():
	SoundPlayer.play("Deny")
	
	$Control.hide()
	$RIP.show()
	
	await get_tree().create_timer(1).timeout
	
	Global.windowsManager.remove_window(self)
	queue_free()


func _process(delta):
	$Control/MarginContainer/VBoxContainer/ProgressBar.set_value($Timer.get_time_left())


func _on_timer_timeout():
	$HungerTimer.start()
	
	$ConfirmationDialog.popup_centered()
	$ConfirmationDialog.grab_focus()


func _on_hunger_timer_timeout():
	Global.healthBar.take_damage(2)
	
	$ConfirmationDialog.popup_centered()
	$ConfirmationDialog.grab_focus()


func _on_confirmation_dialog_close_requested():
	pass

func _on_confirmation_dialog_canceled():
	_on_close_requested()

func _on_confirmation_dialog_confirmed():
	$HungerTimer.stop()
	$Timer.start()


func _on_feed_pressed():
	$HungerTimer.stop()
	$Timer.start()
