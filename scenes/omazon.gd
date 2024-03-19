extends Control

@export var subscription : Subscription;
var checkoutWindow = preload("res://scenes/windows/checkout_window.tscn");

var shame = preload("res://scenes/windows/trick_confirm.tscn")
var ads = preload("res://scenes/windows/ads.tscn")
var tips = preload("res://scenes/windows/tipping_shame.tscn")
var dogshampoo = preload("res://scenes/windows/dogshampoo.tscn")

func _ready():
	await get_tree().create_timer(1).timeout;
	open_sub_trick();

func open_sub_trick():
	$SubTrick.visible = true;
	$SubTrick.init();

func _process(delta):
	pass


func _on_right_button_button_down():
	print("right button");
	SoundPlayer.play("Confirm")
	Global.windowsManager.add_window(checkoutWindow.instantiate());



func _on_bait_button_button_down():
	open_sub_trick();


func _on_coupon_button_pressed():
	SoundPlayer.play("Confirm")
	var w = shame.instantiate()
	Global.windowsManager.add_window(w)


func _on_dog_shampoo_pressed():
	SoundPlayer.play("Confirm")
	var w = dogshampoo.instantiate()
	Global.windowsManager.add_window(w)


func _on_shampoo_ads_pressed():
	SoundPlayer.play("Confirm")
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)
	
	for i in range(randi_range(1, 3)):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
		
		if get_tree():
			await get_tree().create_timer(0.2).timeout


func _on_shampoo_tip_pressed():
	SoundPlayer.play("Confirm")
	var w = tips.instantiate()
	Global.windowsManager.add_window(w)
