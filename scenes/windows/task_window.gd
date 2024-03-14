extends Window

@export var taskList : Dictionary;
var taskNode = preload("res://scenes/windows/task.tscn");
var taskCompletion : Dictionary;

var initialPos;
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.taskWindow = self
	initiate_tasks();
	initialPos = position.y;

func show_window():
	SoundPlayer.play("Confirm")
	
	show()
	
	set_position(Vector2i(0 - size.x, initialPos));
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT);
	tween.tween_property(self, "position", Vector2i(0, initialPos), 0.5);
	
	await tween.finished


func hide_window():
	SoundPlayer.play("Deny")
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT);
	tween.tween_property(self, "position", Vector2i(0 - size.x, initialPos), 0.5);
	
	await tween.finished
	
	hide()


func initiate_tasks():
	for task in taskList:
		var t = taskNode.instantiate();
		t.init_task(task, taskList[task]);
		$Control/TaskContainer.add_child(t);
		taskCompletion[task] = false;


func complete_task(taskId : int):
	# also toggle the button
	$"../TaskButton".set_pressed(true)
	
	await show_window();
	if taskCompletion[taskId]:
		print("task already completed");
		return;
	for task in $Control/TaskContainer.get_children():
		if !task is Task || task.id != taskId: continue;
		task.finish_task();
		taskCompletion[taskId] = true;
		
		# check if all the task if complete
		var allComplete = true
		for i in taskCompletion.values():
			if i == false:
				allComplete = false
		
		if allComplete:
			show_final_completion()


func show_final_completion():
	var final_window = load("res://scenes/windows/congradulation.tscn")
	Global.console.install_app(load("res://arts/icons/Notepad.png"), "Congratulation", final_window)
	
	var w = final_window.instantiate()
	Global.windowsManager.add_window(w)


func show_warning(warning : String):
	pass;
	
	
func _input(ev):
	if (Input.is_key_pressed(KEY_2)):
		return
		show_final_completion()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



