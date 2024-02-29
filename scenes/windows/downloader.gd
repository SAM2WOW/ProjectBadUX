extends "res://scenes/window.gd"


var download = preload("res://scenes/download_buttons.tscn")

func _ready():
	super._ready()
	
	for i in range(20):
		var d = download.instantiate()
		d.set_scale(Vector2(0.5, 0.5))
		$Node2D.add_child(d)
		d.set_position(Vector2(randf_range(12, 500), randf_range(12, 500)))
