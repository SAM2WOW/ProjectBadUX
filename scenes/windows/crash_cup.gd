extends Window


@export var window_icon : Texture2D
@export var window_name : String


func _ready():
	set_title(window_name)

func _on_close_requested():
	pass
