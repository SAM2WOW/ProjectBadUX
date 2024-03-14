extends MarginContainer
class_name Item;

var active = true;
@export var correctItem = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	$VBoxContainer.visible = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	active = $VBoxContainer.visible;

func _on_remove_button_button_down():
	get_parent().move_child(self, get_parent().get_child_count());
	$VBoxContainer.visible = false;
