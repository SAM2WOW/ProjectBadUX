extends Window

var dictionary = preload("res://scenes/windows/dictionary.tscn")

func _ready():
	SoundPlayer.play("Fail2")
	
	position.x = 1280
	var tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", 1065, 0.5);
	
	pass


func _process(delta):
	position.y = 602 - 10 * (get_index())
	
	$Control/ProgressBar.set_value($Timer.get_time_left())

func SetDescription(newDesc : String):
	$Control/Button/MarginContainer/Description.set_text(newDesc)


func _on_infobutton_pressed():
	SoundPlayer.play("Confirm")
	
	var w = dictionary.instantiate()
	
	# don't spawn if window already open, only focus
	if Global.windowsManager.does_window_exist(w.name):
		w.queue_free()
		
		# change page
		
		return
	
	Global.windowsManager.add_window(w)


func _on_timer_timeout():
	_on_close_requested()


func _on_close_requested():
	SoundPlayer.play("Deny")
	queue_free()
