extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout;
	open_sub_trick();
	pass # Replace with function body.

func open_sub_trick():
	$SubTrick.visible = true;
	$SubTrick.init();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
