extends "res://scenes/window.gd"

func _on_close_requested():
	Global.console.crash_game()


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


