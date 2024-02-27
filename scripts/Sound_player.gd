extends Node


var sounds = {
	"Confirm": "Click_Confirm.wav",
	"Deny": "Click_Deny.wav",
	"Crash": "ComputerCrashing.wav",
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