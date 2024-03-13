extends "res://scenes/window.gd"

@onready var archive_box = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox/Archive/Vbox
@onready var inbox_box = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox/Inbox/Vbox
@onready var email_inbox = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox
@onready var email_btn = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailBtns
@onready var email_list = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList
@onready var recover_tab = $Control/CenterContainer/TabContainer

var ads = preload("res://scenes/windows/ads.tscn")
var ads_video = preload("res://scenes/windows/ads_video.tscn")
var cup = preload("res://scenes/windows/crash_cup.tscn")
var dvd = preload("res://scenes/windows/dvd.tscn")
var thankyou = preload("res://scenes/windows/thankyou.tscn")
var thankyou2 = preload("res://scenes/windows/thankyou2.tscn")

var current_email

var email_delete_count = 0

func _ready():
	super._ready()
	
	# connect all the email icons
	for i in inbox_box.get_children():
		if i.sender_email in Global.deleted_emails:
			i.queue_free()
		else:
			i.connect("btn_pressed", _on_email_button_pressed)
	
	for i in archive_box.get_children():
		if i.sender_email in Global.deleted_emails:
			i.queue_free()


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
	
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer/Sender.set_text(btn.sender)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer/FromMail.set_text(btn.sender_email)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer2/Label2.set_text(btn.receive_email)
	$Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/HBoxContainer3/Label.set_text(btn.email_title)
	
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
	SoundPlayer.play("Confirm")
	
	current_email = null
	
	email_inbox.show()
	email_btn.hide()
	email_list.hide()
	
	for i in $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailList/VBoxContainer/Panel/ScrollContainer/VBoxContainer.get_children():
		i.queue_free()


func _on_delete_pressed():
	SoundPlayer.play("Fail")
	
	Global.deleted_emails.append(current_email.sender_email)
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


func _on_icon_pressed():
	recover_tab.set_current_tab(0)
	
	$Control/CenterContainer.show()
	$Control/MarginContainer.hide()


func return_to_inbox():
	SoundPlayer.play("Confirm")
	
	$Control/CenterContainer.hide()
	$Control/MarginContainer.show()


func _on_yes_pressed():
	SoundPlayer.play("Confirm")
	recover_tab.set_current_tab(1)


func _on_continue_pressed():
	var state = $Control/CenterContainer/TabContainer/Panel2/CenterContainer/VBoxContainer/HBoxContainer2/CheckBox.is_pressed()
	
	if state:
		return_to_inbox()
		
	else:
		SoundPlayer.play("Confirm")
		recover_tab.set_current_tab(2)


func _on_continue2_pressed():
	var password = $Control/CenterContainer/TabContainer/Panel3/CenterContainer/VBoxContainer/LineEdit.get_text()
	
	if password == "251234":
		SoundPlayer.play("Confirm")
		recover_tab.set_current_tab(3)
	else:
		SoundPlayer.play("Deny")


func _on_recover_pressed():
	$Control/CenterContainer.hide()
	
	$CorruptedMiniGame.play()
	
	$RecoveryGame.show()
	$RecoveryGame.set_process_mode(Node.PROCESS_MODE_INHERIT)


func _on_recovery_game_dead():
	SoundPlayer.play("Deny")
	$Control/CenterContainer.show()
	
	$CorruptedMiniGame.stop()
	
	$RecoveryGame.hide()
	$RecoveryGame.set_process_mode(Node.PROCESS_MODE_DISABLED)


func _on_recovery_game_win():
	$CorruptedMiniGame.stop()
	
	$RecoveryGame.hide()
	$RecoveryGame.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	# delete the email
	var email = $Control/MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer2/EmailInbox/Archive/Vbox/Icon
	email.queue_free()
	Global.deleted_emails.append(email.sender_email)
	
	Global.taskWindow.complete_task(3)
	
	return_to_inbox()


func _on_redcross_pressed():
	SoundPlayer.play("Confirm")
	var w = thankyou.instantiate()
	Global.windowsManager.add_window(w)


func _on_moogle_pressed():
	SoundPlayer.play("Confirm")
	var w = thankyou2.instantiate()
	Global.windowsManager.add_window(w)
