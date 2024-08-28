extends Label
class_name Task

var id;
var taskText

var completed_texture = preload("res://Themes/Classic95/Styles/CheckBox/Checked.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_task(taskId : int, newTaskText : String):
	taskText = newTaskText
	
	id = taskId;
	text = "     %s" % taskText

func finish_task(effect : bool):
	print("task finished!");
	set("theme_override_colors/font_color",Color("00ec56"))
	
	text = "     %s" % taskText
	
	$TextureRect.set_texture(completed_texture)
	
	if effect:
		SoundPlayer.play("Success")
