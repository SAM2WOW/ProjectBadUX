extends "res://scenes/window.gd"


var tips = 50

func _process(delta):
	$Control/CenterContainer/Customize/LineEdit.set_text("%d" % tips + "%")

func _on_confirm_pressed():
	if tips != 0:
		SoundPlayer.play("Confirm")
		$Control/CenterContainer/Tips.hide()
		$Control/CenterContainer/Customize.hide()
		$"Control/CenterContainer/Thank you".show()
		
		Global.healthBar.take_damage(abs(tips), "Maybe check the vendor before tipping!")
	
	else:
		_on_close_requested()


func _on_per_pressed():
	SoundPlayer.play("Confirm")
	tips = 15


func _on_per20_pressed():
	SoundPlayer.play("Confirm")
	tips = 20


func _on_per50_pressed():
	SoundPlayer.play("Confirm")
	tips = 50


func _on_customize_pressed():
	$Control/CenterContainer/Tips.hide()
	$Control/CenterContainer/Customize.show()


func _on_add_3_pressed():
	tips += 3


func _on_sub_4_pressed():
	tips -= 4


func _on_mult_2_pressed():
	tips *= 2


func _on_close_pressed():
	_on_close_requested()
