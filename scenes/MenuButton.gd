extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	if not $"../TaskList".is_visible():
		$"../TaskList".show_window();
	else:
		$"../TaskList".hide_window();



func _on_toggled(toggled_on):
	if toggled_on:
		$"../TaskList".show_window();
	else:
		$"../TaskList".hide_window();
