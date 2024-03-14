extends ColorRect

var doneStall = false;

var ads = preload("res://scenes/windows/ads.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	init();

func init():
	doneStall = false;
	$"../SubBar".visible = false;
	$SubDropDowns.visible = true;
	$SubDropDowns2.visible = false;
	$UnsubScreen.visible = false;
	for child in $SubDropDowns/VBoxContainer.get_children():
		child.visible = false;
	$SubDropDowns/VBoxContainer/Label.visible = true;
	$SubDropDowns/VBoxContainer/MarginContainer.visible = true;
	$SubDropDowns2/VBoxContainer/MarginContainer.visible = false;
	$SubDropDowns2/VBoxContainer/MarginContainer2.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close():
	SoundPlayer.play("Deny")
	
	visible = false;
	doneStall = true;
	$Timer.stop();

func _on_sub_bar_button_down():
	visible = true;
	init();


func _on_settings_button_button_down():
	$"../SubBar".visible = !$"../SubBar".visible;


func _on_sub_1_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns/VBoxContainer/MarginContainer2.visible = true;

func _on_sub_2_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns/VBoxContainer/MarginContainer3.visible = true;

func _on_sub_3_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns/VBoxContainer/MarginContainer4.visible = true;
	$SubDropDowns/VBoxContainer/MarginContainer5.visible = true;

func _on_sub_4_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns/VBoxContainer/MarginContainer2.visible = false;
	$SubDropDowns/VBoxContainer/MarginContainer3.visible = false;
	$SubDropDowns/VBoxContainer/MarginContainer4.visible = false;
	$SubDropDowns/VBoxContainer/MarginContainer5.visible = false;
	$SubDropDowns/VBoxContainer/MarginContainer6.visible = false;

func _on_sub_5_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns/VBoxContainer/MarginContainer6.visible = true;


func _on_cancel_button_down():
	SoundPlayer.play("Confirm")
	$SubDropDowns.visible = false;
	$SubDropDowns2.visible = true;
	start_stall();

func start_stall():
	doneStall = false;
	$Timer.wait_time = 10;
	$Timer.start();
	dotdotdot();
	await $Timer.timeout;
	$SubDropDowns2/VBoxContainer/MarginContainer.visible = true;
	await get_tree().create_timer(3).timeout;
	if visible && $SubDropDowns2.visible:
		$SubDropDowns2/VBoxContainer/MarginContainer2.visible = true;

func dotdotdot():
	$SubDropDowns2/VBoxContainer/Label3.text = "...";
	await get_tree().create_timer(1).timeout;
	while !doneStall:
		if $SubDropDowns2/VBoxContainer/Label3.text == "...":
			$SubDropDowns2/VBoxContainer/Label3.text = "";
		$SubDropDowns2/VBoxContainer/Label3.text += '.';
		await get_tree().create_timer(1).timeout;


func _on_cancel_sub_1_button_down():
	SoundPlayer.play("Deny")
	doneStall = true;
	$SubDropDowns2.visible = false;
	$UnsubScreen.visible = true;
	
func unsubscribe():
	Global.remove_sub($"..".subscription.id);
	close();


func _on_ads_pressed():
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)
	
	var w = ads.instantiate()
	Global.windowsManager.add_window(w)
