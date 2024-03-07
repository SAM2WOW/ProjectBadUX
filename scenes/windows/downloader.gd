extends "res://scenes/window.gd"


var download = preload("res://scenes/download_buttons.tscn")


func _ready():
	super._ready()
	
	var goodx = randi_range(0, 4)
	var goody = randi_range(0, 4)
	
	for x in range(5):
		for y in range(5):
			var isGood = (x == goodx and y == goody)
			if randi() % 2 or isGood:
				var d = download.instantiate()
				d.set_scale(Vector2(0.5, 0.5))
				
				if isGood:
					d.bad = false
				else:
					d.bad = true
				
				$Node2D.add_child(d)
				#d.set_position(Vector2(randf_range(12, 500), randf_range(12, 500)))
				d.set_position(Vector2((x * 420 / 5) + 80, (y * 420 / 5) + 80))
