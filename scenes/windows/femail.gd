extends "res://scenes/window.gd"

@onready var archive_box = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox/Archive/Vbox
@onready var inbox_box = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox/Inbox/Vbox
@onready var email_inbox = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox
@onready var email_btn = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailBtns
@onready var email_list = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList

var ads = preload("res://scenes/windows/ads.tscn")
var ads_video = preload("res://scenes/windows/ads_video.tscn")
var cup = preload("res://scenes/windows/crash_cup.tscn")
var dvd = preload("res://scenes/windows/dvd.tscn")

var current_email

var email_delete_count = 0

func _ready():
	super._ready()
	
	# connect all the email icons
	for i in inbox_box.get_children():
		i.connect("btn_pressed", _on_email_button_pressed)
	for i in archive_box.get_children():
		i.connect("btn_pressed", _on_email_button_pressed)


func _process(delta):
	# set the counter on the email button
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Inbox.set_text(" 
📥 Inbox (%d)
 " % [inbox_box.get_child_count()])
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/Archive.set_text("  
📂 Archive(%d)
 " % [archive_box.get_child_count()])


func _on_email_button_pressed(btn):
	current_email = btn
	
	print("btn_pressedd")
	
	current_email.set_read()
	
	email_inbox.hide()
	email_btn.show()
	email_list.show()
	
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer/From.set_text("   From:       " + btn.sender)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer/FromMail.set_text(btn.sender_email)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer2/To.set_text("   To:            " + btn.receive_email)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer3/Subject.set_text("   Subject:   " + btn.email_title)
	
	for i in btn.get_node("Content").get_children():
		var new_node = i.duplicate()
		print(new_node.name)
		$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/Panel/ScrollContainer/VBoxContainer.add_child(new_node)

func _on_archive_pressed():
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox.set_current_tab(1)
	
	_on_back_pressed()

func _on_inbox_pressed():
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox.set_current_tab(0)

	_on_back_pressed()

func _on_back_pressed():
	current_email = null
	
	email_inbox.show()
	email_btn.hide()
	email_list.hide()
	
	for i in $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/Panel/ScrollContainer/VBoxContainer.get_children():
		i.queue_free()


func _on_delete_pressed():
	current_email.queue_free()
	
	if current_email.bad:
		email_delete_count += 1
		
		if email_delete_count == 3:
			Global.taskWindow.complete_task(2)
	else:
		Global.healthBar.take_damage(20)
		Global.warningWindow.AddWarning(1)
	
	_on_back_pressed()


func _on_virus_pressed():
	var w = cup.instantiate()
	Global.windowsManager.add_window(w)
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)

func _on_bad_link_pressed():
	for i in range(2):
		var w = ads.instantiate()
		Global.windowsManager.add_window(w)
	
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)


func _on_dvd_pressed():
	Global.healthBar.take_damage(10)
	Global.warningWindow.AddWarning(0)
	
	var w = dvd.instantiate()
	Global.windowsManager.add_window(w)
