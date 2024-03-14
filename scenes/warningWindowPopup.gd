extends Window

var dictionary = preload("res://scenes/windows/dictionary.tscn")
var page = 0

func _ready():
	SoundPlayer.play("Fail2")
	
	position.x = 1280
	var tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", 1065, 0.5);
	
	pass


func _process(delta):
	position.y = 602 - 10 * (get_index())
	
	$Control/ProgressBar.set_value($Timer.get_time_left())

func SetDescription(newDesc):
	$Control/Button/MarginContainer/Description.set_text(newDesc[0])
	page = newDesc[1]


func _on_infobutton_pressed():
	var w = dictionary.instantiate()
	
	# don't spawn if window already open, only focus
	if Global.windowsManager.does_window_exist(w.name):
		w.queue_free()
		
		# change page
		Global.windowsManager.opened_windows[w.name].window.set_page(page - 1)
		return
	
	Global.windowsManager.add_window(w)
	w.set_page(page - 1)
	
	_on_close_requested()


func _on_timer_timeout():
	_on_close_requested()


func _on_close_requested():
	SoundPlayer.play("Deny")
	queue_free()
