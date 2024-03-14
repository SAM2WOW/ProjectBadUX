extends Window


@export var window_icon : Texture2D
@export var window_name : String


func _ready():
	set_title(window_name)
	
	"""
	var final_size = get_size()
	var intial_pos = get_position()
	set_size(Vector2i(1, 1))
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "size", final_size, 0.25)
	tween.parallel().tween_property(self, "position", intial_pos + final_size / 2, 0.25)
	"""


func _on_close_requested():
	Global.windowsManager.remove_window(self)
	
	queue_free()
	
	SoundPlayer.play("Deny")


func _on_button_pressed():
	_on_close_requested()
