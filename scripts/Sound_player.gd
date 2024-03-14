extends Node


var sounds = {
	"Confirm": "Click_Confirm.wav",
	"Deny": "Click_Deny.wav",
	"Crash": "ComputerCrashing.wav",
	"Fail": "FailNoise.wav",
	"Fail2": "FailNoise2.wav",
	"Success": "Success.wav",
	"PageTurn": "Pageturn.wav",
	"Trash": "Trash_Sound.wav",
	"Damage": "FailSplit2.wav",
	"Yay": "Yay.wav",
	"Hammy3": "Hampoter3.wav",
	"Hammy1": "Hampter1.wav",
	"Hammy2": "Hampter2.wav",
}


func _ready():
	for i in sounds.keys():
		var s = AudioStreamPlayer.new()
		s.set_stream(load("res://sounds/%s" % sounds[i]))
		s.set_bus("Sound")
		s.name = i
		add_child(s)


func play(sound_name):
	get_node(sound_name).play()
