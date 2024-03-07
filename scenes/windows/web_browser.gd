extends "res://scenes/window.gd"


var ads = preload("res://scenes/windows/ads.tscn")
var ads_video = preload("res://scenes/windows/ads_video.tscn")
var cup = preload("res://scenes/windows/crash_cup.tscn")
var downloader = preload("res://scenes/windows/downloader.tscn")

var spawn_time = 2.0
var duck = preload("res://scenes/duck.tscn")
var duck_mode = false


func _ready():
	super._ready()
	$Control/ScrollContainer/TabContainer/GoogleFrontPage/VBoxContainer/HBoxContainer/TextEdit.grab_focus()
	
	# shuffle search results
	for i in $Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3.get_children():
		$Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3.move_child(i, randi_range(0, 3))
	

func _process(delta):
	$Node2D/Crosshair.set_position($Node2D.get_local_mouse_position())
	
	if not $Timer.is_stopped():
		$Control/ScrollContainer/TabContainer/DuckCaptcha/VBoxContainer/ProgressBar.set_value(1.0 - ($Timer.get_time_left() / 15.0))
		
		$Control/ScrollContainer/TabContainer/DuckCaptcha/VBoxContainer/Label.set_text(">>> Please Remove All The AI Ducks <<<
 
Download link ready in %d seconds ..." % $Timer.get_time_left())


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if duck_mode:
				$Gun.play()


func _on_search_button_pressed():
	var text = $Control/ScrollContainer/TabContainer/GoogleFrontPage/VBoxContainer/HBoxContainer/TextEdit.get_line(0)
	
	if "duck" in text.to_lower():
		$Control/ScrollContainer/TabContainer.set_current_tab(1)
		SoundPlayer.play("Confirm")

func _on_text_edit_caret_changed():
	_on_search_button_pressed()


func _on_bad_website_1_pressed():
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)
	
	for i in range(4):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout

func _on_bad_website_2_pressed():
	#var w = cup.instantiate()
	#Global.windowsManager.add_window(w)
	
	#_on_button_pressed()
	
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)
	
	for i in range(2):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout

func _on_good_website_pressed():
	SoundPlayer.play("Confirm")
	
	$Control/ScrollContainer/TabContainer.set_current_tab(2)
	
	$Timer.start()
	$SpawnTimer.start()
	
	$Node2D/Crosshair.show()
	$Node2D/Grass.show()
	
	$CorruptedMiniGame.play()
	
	duck_mode = true

func _on_bad_website_3_pressed():
	SoundPlayer.play("Confirm")
	
	var w = ads_video.instantiate()
	Global.windowsManager.add_window(w)
	
	Global.warningWindow.AddWarning(0)


func _on_bad_website_1_mouse_entered():
	$Control/Label.set_text("https://www.thiswebsitenotsafe.com")

func _on_bad_website_2_mouse_entered():
	$Control/Label.set_text("https://www.definitelynotvirus.com")

func _on_good_website_mouse_entered():
	$Control/Label.set_text("https://www.ducklover123.com")

func _on_bad_website_3_mouse_entered():
	$Control/Label.set_text("https://www.absolutelyfreeimage.com")


func _on_bad_website_1_mouse_exited():
	$Control/Label.set_text("")

func _on_bad_website_2_mouse_exited():
	$Control/Label.set_text("")

func _on_good_website_mouse_exited():
	$Control/Label.set_text("")
	
func _on_bad_website_3_mouse_exited():
	$Control/Label.set_text("")





func _on_timer_timeout():
	duck_mode = false
	
	$SpawnTimer.stop()
	
	$Node2D/Crosshair.hide()
	$Node2D/Ducks.hide()
	$Node2D/Grass.hide()
	
	$CorruptedMiniGame.stop()
	
	for i in $Node2D/Ducks.get_children():
		i.queue_free()
	
	$Control/ScrollContainer/TabContainer.set_current_tab(3)
	SoundPlayer.play("Confirm")


func _on_spawn_timer_timeout():
	#if spawn_time > 0.4:
	#	spawn_time = spawn_time * 0.9
		
	$SpawnTimer.start(spawn_time)
	
	print("DUCK")
	
	var d = duck.instantiate()
	$Node2D/Ducks.add_child(d)
	#d.set_position(Vector2(randf_range(0, 720), 527))
	d.set_position(Vector2(720 / 2, 527))
	
	d.connect("duck_kill", _on_duck_kill)
	if d.bad:
		d.connect("duck_out", _on_duck_out)


func _on_duck_out():
	#var left_time = max($Timer.get_time_left() + 2, 0.0)
	
	#$Timer.start(left_time)
	Global.healthBar.take_damage(5)
	Global.warningWindow.AddWarning(1)
	pass


func _on_duck_kill():
	#var left_time = max($Timer.get_time_left() + 2, 0.0)
	
	#$Timer.start(left_time)
	
	$Killed.play()
	
	pass


func _on_download_pressed():
	var w = downloader.instantiate()
	Global.windowsManager.add_window(w)
	
	_on_button_pressed()
