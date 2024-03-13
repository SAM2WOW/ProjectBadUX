extends ColorRect

var swapped = false;
var dogWhine = preload("res://sounds/ads/dogWhine.wav");

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	init();

func init():
	$SubPrompt.visible = true;
	$SubscribeScreen.visible = false;
	$SubscribeScreen2.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_no_label_mouse_entered():
	if swapped: return;
	swapped = true;
	var noButton = $SubPrompt/VBoxContainer/HBoxContainer2/NoButton;
	var yesButton = $SubPrompt/VBoxContainer/HBoxContainer/MarginContainer2/Subscribe;
	noButton.set_flat(false);
	yesButton.set_flat(true);
	
	var yes_pos = yesButton.global_position;
	var no_pos = noButton.global_position;
	
	noButton.get_parent().remove_child(noButton);
	yesButton.get_parent().remove_child(yesButton);
	
	noButton.set("theme_override_colors/font_color",Color.BLACK);
	
	$SubPrompt/VBoxContainer/HBoxContainer/MarginContainer2.add_child(noButton);
	$SubPrompt/VBoxContainer/HBoxContainer2.add_child(yesButton);
	
	# print(yes_pos, " vs ", no_pos);
	#var tween = create_tween();
	#tween.tween_property(yesButton, "global_position", no_pos, 0.1);
	#tween.parallel().tween_property(noButton, "global_position", yes_pos, 0.1);
	
func subscribe():
	print("sub");
	$SubPrompt.visible = false;
	$SubscribeScreen2.visible = false;
	$SubscribeScreen.visible = true;

func subscribe2():
	subscribe();
	
func no_subscribe():
	$SubPrompt.visible = false;
	$SubscribeScreen2.visible = true;

func close():
	$"../AudioStreamPlayer2D".stop();
	visible = false;


func _on_no_sub_mouse_entered():
	if !$"../AudioStreamPlayer2D".is_playing():
		$"../AudioStreamPlayer2D".stream = dogWhine;
		$"../AudioStreamPlayer2D".play();


func _on_no_sub_mouse_exited():
	$"../AudioStreamPlayer2D".stop();

