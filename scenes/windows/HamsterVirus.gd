extends "res://scenes/window.gd"

func _ready():
	super._ready()
	
	SoundPlayer.play("Hammy1")


func _on_close_requested():
	SoundPlayer.play("Deny")
	SoundPlayer.play("Hammy3")
	
	$Control.hide()
	$RIP.show()
	
	await get_tree().create_timer(2).timeout
	
	Global.windowsManager.remove_window(self)
	queue_free()


func _process(delta):
	$Control/MarginContainer/VBoxContainer/ProgressBar.set_value($Timer.get_time_left())


func _on_timer_timeout():
	$HungerTimer.start()
	
	$ConfirmationDialog.popup_centered()
	$ConfirmationDialog.grab_focus()
	
	SoundPlayer.play("Fail")


func _on_hunger_timer_timeout():
	Global.healthBar.take_damage(2, "Hammy Killed You. So Kawaii")
	
	SoundPlayer.play("Hammy1")
	
	$ConfirmationDialog.popup_centered()
	$ConfirmationDialog.grab_focus()


func _on_confirmation_dialog_close_requested():
	pass

func _on_confirmation_dialog_canceled():
	_on_close_requested()

func _on_confirmation_dialog_confirmed():
	_on_feed_pressed()


func _on_feed_pressed():
	$HungerTimer.stop()
	$Timer.start()
	
	SoundPlayer.play("Hammy2")
