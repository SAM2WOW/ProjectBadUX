extends Window

signal confirmed
signal canceled

@export var window_icon : Texture2D
@export var window_name : String

@export var second_trick = false

var trick_finished = false
var tween


func _ready():
	set_title(window_name)
	
	await get_tree().create_timer(1).timeout
	
	$Node2D/No.show()


func _on_close_requested():
	pass


func _on_no_pressed():
	SoundPlayer.play("Deny")
	Global.windowsManager.add_window($ConfirmationDialog)
	$ConfirmationDialog.show()
	$ConfirmationDialog.popup_centered()


func _on_yes_pressed():
	emit_signal("confirmed")
	
	Global.healthBar.take_damage(10, "Ouch! You fell for the tricks!")
	Global.warningWindow.AddWarning(12)
	
	SoundPlayer.play("Confirm")
	Global.windowsManager.remove_window(self)
	queue_free()


func _on_no_mouse_entered():
	if not trick_finished:
		trick_finished = true
		
		$Node2D/No.set_flat(false)
		$Node2D/Confirm.set_flat(true)
		
		var yes_pos = $Node2D/Confirm.get_position()
		var no_pos = $Node2D/No.get_position()
		
		tween = create_tween()
		tween.tween_property($Node2D/Confirm, "position", no_pos, 0.1)
		tween.parallel().tween_property($Node2D/No, "position", yes_pos, 0.1)


func _on_confirmation_dialog_canceled():
	SoundPlayer.play("Deny")
	Global.windowsManager.remove_window($ConfirmationDialog)
	$ConfirmationDialog.hide()


func _on_confirmation_dialog_confirmed():
	emit_signal("canceled")
	
	SoundPlayer.play("Confirm")
	Global.windowsManager.remove_window($ConfirmationDialog)
	Global.windowsManager.remove_window(self)
	queue_free()
