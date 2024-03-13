extends Button

signal btn_pressed

@export var bad = false
@export var read = false
@export var sender = ""

@export var sender_email = ""
@export var receive_email = ""

@export var email_title = ""
@export var date = ""


func _ready():
	$HBoxContainer/CheckBox.set_pressed(read)
	$HBoxContainer/Sender.set_text(sender)
	$HBoxContainer/Title.set_text(email_title)
	$HBoxContainer/Date.set_text(date)


func _on_pressed():
	SoundPlayer.play("Confirm")
	
	emit_signal("btn_pressed", self)


func set_read():
	read = true
	$HBoxContainer/CheckBox.set_pressed(read)
