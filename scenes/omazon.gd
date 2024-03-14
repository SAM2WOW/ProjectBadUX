extends Control

@export var subscription : Subscription;
var checkoutWindow = preload("res://scenes/windows/checkout_window.tscn");

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


func _on_right_button_button_down():
	print("right button");
	Global.windowsManager.add_window(checkoutWindow.instantiate());



func _on_bait_button_button_down():
	open_sub_trick();
