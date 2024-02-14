extends Window


@export var window_icon : Texture2D
@export var window_name : String

var trick = true
var trick_finished = false
var tween

func _ready():
	set_title(window_name)
	
	randomize()


func _process(delta):
	$Control/CenterContainer/VBoxContainer/Label.set_text("YOUR PC WILL CRASH IN %d Seconds" % $Timer.get_time_left())

func _on_close_requested():
	pass


func _on_timer_timeout():
	Global.console.crash_game()


func _on_confirm_mouse_entered():
	if trick:
		trick = false
		
		$Node2D/Cup2/CONFIRM.set_disabled(true)
		
		#$Node2D/Cup2/CONFIRM.position = Vector2(88.43, -162.66)
		tween = create_tween()
		tween.tween_property($Node2D/Cup2/CONFIRM, "position", Vector2(88.43, -19.385), 0.5)
		
		var table = [$Node2D/Cup1, $Node2D/Cup2, $Node2D/Cup3]
		for i in range(19):
			var temp = table.duplicate()
			
			while temp == table:
				table.shuffle()
			
			tween.tween_property(table[0], "position", Vector2(228.185, 312.295), 2 - i / 10.0)
			tween.parallel().tween_property(table[1], "position", Vector2(428.505, 312.295), 2 - i / 10.0)
			tween.parallel().tween_property(table[2], "position", Vector2(615.135, 312.295), 2 - i / 10.0)
		
		tween.connect("finished", on_tween_finished)


func on_tween_finished():
	trick_finished = true
	
	$Node2D/Cup2/CONFIRM.set_disabled(false)
	$Node2D/Cup3/Cancel.set_disabled(false)
	
	tween = create_tween()
	tween.tween_property($Node2D/Cup2/CONFIRM, "position", Vector2(88.43, -162.66), 0.3)
	tween.tween_property($Node2D/Cup3/Cancel, "position", Vector2(84.815, -162.66), 1)


func _on_confirm_pressed():
	$Control/CenterContainer/VBoxContainer/Label2.set_text("GOOD BYE")
	$Timer.start(2)
	
	$Node2D.hide()


func _on_cancel_pressed():
	$Timer.stop()
	$Control/CenterContainer/VBoxContainer/Label.hide()
	
	await get_tree().create_timer(1).timeout
	
	Global.windowsManager.remove_window(self)
	queue_free()
