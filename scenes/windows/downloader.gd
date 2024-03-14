extends "res://scenes/window.gd"


var download = preload("res://scenes/download_buttons.tscn")


func _ready():
	super._ready()
	
	var good_point = $Node2D/Positions.get_children().pick_random()
	
	"""
	var goodx = randi_range(0, 2)
	var goody = randi_range(0, 4)
	
	for x in range(4):
		for y in range(5):
			var isGood = (x == goodx and y == goody)
			if randi() % 2 or isGood:
				var d = download.instantiate()
				d.set_scale(Vector2(0.5, 0.5))
				
				if isGood:
					d.bad = false
					d.connect("selected", donwload)
				else:
					d.bad = true
				
				$Node2D.add_child(d)
				#d.set_position(Vector2(randf_range(12, 500), randf_range(12, 500)))
				d.set_position(Vector2((x * 420 / 3) + 80 + randf_range(-50, 50), (y * 420 / 5) + 80 + randf_range(-50, 50)))
	"""
	
	for i in $Node2D/Positions.get_children():
		if randi() % 2 or i == good_point:
			var d = download.instantiate()
			d.set_scale(Vector2(0.5, 0.5))
			
			if i == good_point:
				d.bad = false
				d.connect("selected", donwload)
			else:
				d.bad = true
			
			$Node2D.add_child(d)
			d.set_position(i.get_position())


func donwload():
	$Control.hide()
	$Finished.show()
	
	Global.taskWindow.complete_task(1)
	
	for i in $Node2D.get_children():
		i.queue_free()
	
	Global.console.install_app(load("res://arts/ducks/duck.png"), "Duck.jpg", load("res://scenes/windows/duck.tscn"))


func _on_download_pressed():
	_on_button_pressed()
