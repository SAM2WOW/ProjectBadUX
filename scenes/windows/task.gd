extends Label
class_name Task

var id;
var taskText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_task(taskId : int, newTaskText : String):
	taskText = newTaskText
	
	id = taskId;
	text = "☐ %s" % taskText

func finish_task():
	print("task finished!");
	set("theme_override_colors/font_color",Color("00ec56"))
	
	text = "🗹 %s" % taskText
	
	SoundPlayer.play("Success")
