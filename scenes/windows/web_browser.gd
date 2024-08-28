extends "res://scenes/window.gd"


var ads = preload("res://scenes/windows/ads.tscn")
var ads_video = preload("res://scenes/windows/ads_video.tscn")
var cup = preload("res://scenes/windows/crash_cup.tscn")
var downloader = preload("res://scenes/windows/downloader.tscn")
var hammy = preload("res://scenes/windows/HamsterVirus.tscn")

var spawn_time = 2.0
var duck = preload("res://scenes/duck.tscn")
var duck_mode = false

var random_title = [
	"Duck Tape: Just a name that rhymes with duct tape",
	"Webster: Awesome name for talkative ducks",
	"Funny name for male ducks that love to dominate",
	"Communicating with ducks through interpretive quacking",
	"What Duck Is That?",
	"Download Free Duck Image Here",
	"4000+ Best Duck Photos · 100% Free Download",
	"1000+ Ducks Pictures | Download Free Images on ...",
	"Duck Stock Photos, Images & Pictures",
	"417214 Duck Stock Photos",
	"Duck Images [Hd] - Download Duck Pictures For Free",
]

var title_btns = [
	"Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3/VBoxContainer/HBoxContainer2/BadWebsite1",
	"Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3/VBoxContainer2/HBoxContainer/BadWebsite2",
	"Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3/VBoxContainer3/HBoxContainer/GoodWebsite",
	"Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3/VBoxContainer4/HBoxContainer/BadWebsite3"
]


func _ready():
	super._ready()
	$Control/ScrollContainer/TabContainer/GoogleFrontPage/VBoxContainer/HBoxContainer/LineEdit.grab_focus()
	
	# shuffling random title names
	random_title.shuffle()
	for i in title_btns:
		var newtitle = random_title.pop_back()
		get_node(i).set_text(newtitle)
		
	# shuffle search results
	for x in range(2, 4):
		var i = $Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3.get_child(x)
		$Control/ScrollContainer/TabContainer/SearchResults/MarginContainer/VBoxContainer3.move_child(i, randi_range(2, 4))


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
	var text = $Control/ScrollContainer/TabContainer/GoogleFrontPage/VBoxContainer/HBoxContainer/LineEdit.get_text()
	
	if "duck" in text.to_lower():
		$Control/ScrollContainer/TabContainer.set_current_tab(1)
		SoundPlayer.play("Confirm")
		
		$Control/Panel.show()
	else:
		SoundPlayer.play("Fail2")

func _on_line_edit_text_submitted(new_text):
	_on_search_button_pressed()


func _on_bad_website_1_pressed():
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10, "Don't click the bad websites!")
	Global.warningWindow.AddWarning(0)
	
	for i in range(4):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout

func _on_bad_website_2_pressed():
	var w = hammy.instantiate()
	Global.windowsManager.add_window(w)
	
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10 ,"Don't click the bad websites!")
	Global.warningWindow.AddWarning(0)
	
	Global.console.install_app(load("res://arts/gif/hamster (1).png"), "Hammy", load("res://scenes/windows/HamsterVirus.tscn"))
	
	"""2):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout
	"""


func _on_good_website_pressed():
	SoundPlayer.play("Confirm")
	
	$Control/ScrollContainer/TabContainer.set_current_tab(2)
	
	$Timer.start()
	$SpawnTimer.start()
	
	$Node2D/Crosshair.show()
	$Node2D/Grass.show()
	
	$Control/Panel.hide()
	
	$CorruptedMiniGame.play()
	
	duck_mode = true

func _on_bad_website_3_pressed():
	SoundPlayer.play("Confirm")
	
	var w = ads_video.instantiate()
	Global.windowsManager.add_window(w)
	
	Global.warningWindow.AddWarning(0)


func _on_bad_website_1_mouse_entered():
	$Control/Panel/Label.set_text("https://www.thiswebsitenotsafe.com")

func _on_bad_website_2_mouse_entered():
	$Control/Panel/Label.set_text("https://www.definitelynotvirus.com")

func _on_good_website_mouse_entered():
	$Control/Panel/Label.set_text("https://www.ducklover123.com")

func _on_bad_website_3_mouse_entered():
	$Control/Panel/Label.set_text("https://www.absolutelyadsfreeimage.com")


func _on_bad_website_1_mouse_exited():
	$Control/Panel/Label.set_text("")

func _on_bad_website_2_mouse_exited():
	$Control/Panel/Label.set_text("")

func _on_good_website_mouse_exited():
	$Control/Panel/Label.set_text("")
	
func _on_bad_website_3_mouse_exited():
	$Control/Panel/Label.set_text("")





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
	SoundPlayer.play("Yay")


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
	Global.healthBar.take_damage(5, "You missed the AI ducks!")
	Global.warningWindow.AddWarning(10)
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
