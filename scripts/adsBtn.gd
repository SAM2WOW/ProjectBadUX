extends TextureButton


var ads = preload("res://scenes/windows/ads.tscn")
@export var amount = 1


func _on_pressed():
	Global.healthBar.take_damage(10, "The ads got you!")
	Global.warningWindow.AddWarning(3)
	
	for i in range(amount):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout
