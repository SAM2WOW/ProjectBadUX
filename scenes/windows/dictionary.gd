extends "res://scenes/window.gd"

var totalTabs = 1
var currentTabs = 0


func _ready():
	super._ready()
	
	totalTabs = $Control/MarginContainer/VBoxContainer/TabContainer.get_tab_count()
	
	$Control/MarginContainer/VBoxContainer/HBoxContainer/Label.set_text("%d/%d" % [currentTabs + 1, totalTabs])
	
	$Control/MarginContainer/VBoxContainer/HSlider.set_max(totalTabs)


func _on_tab_container_tab_changed(tab):
	SoundPlayer.play("PageTurn")
	
	currentTabs = tab
	$Control/MarginContainer/VBoxContainer/HBoxContainer/Label.set_text("%d/%d" % [currentTabs + 1, totalTabs])
	
	$Control/MarginContainer/VBoxContainer/HSlider.set_value(currentTabs + 1)

func _on_prev_pressed():
	$Control/MarginContainer/VBoxContainer/TabContainer.select_previous_available()


func _on_next_pressed():
	$Control/MarginContainer/VBoxContainer/TabContainer.select_next_available()


func _on_h_slider_value_changed(value):
	$Control/MarginContainer/VBoxContainer/TabContainer.set_current_tab(value - 1)

