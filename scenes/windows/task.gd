extends Label
class_name Task

var id;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_task(taskId : int, taskText : String):
	id = taskId;
	text = taskText;

func finish_task():
	print("task finished!");
	set("theme_override_colors/font_color",Color.GREEN)
