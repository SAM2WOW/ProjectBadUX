extends Control

@export var taskList : Dictionary;
var taskNode = preload("res://scenes/windows/task.tscn");
var taskCompletion : Dictionary;
var initialPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	initiate_tasks();
	visible = false;
	initialPos = position.y;
	
func show_window():
	SoundPlayer.play("Confirm")
	visible = true;
	set_position(Vector2(position.x, 50));
	var tween =  create_tween().set_trans(Tween.TRANS_EXPO);
	tween.tween_property(self, "position", Vector2(position.x, initialPos), 1);
	await tween.finished;

func hide_window():
	SoundPlayer.play("Deny")
	var tween =  create_tween().set_trans(Tween.TRANS_EXPO);
	tween.tween_property(self, "position", Vector2(position.x, 50), 1);
	await tween.finished;
	visible = false;

func initiate_tasks():
	for task in taskList:
		var t = taskNode.instantiate();
		t.init_task(task, taskList[task]);
		$TaskContainer.add_child(t);
		taskCompletion[task] = false;

func complete_task(taskId : int):
	await show_window();
	if taskCompletion[taskId]:
		print("task already completed");
		return;
	for task in $TaskContainer.get_children():
		if !task is Task || task.id != taskId: continue;
		task.finish_task();
	taskCompletion[taskId] = true;

func show_warning(warning : String):
	pass;
	
func _input(ev):
	if (Input.is_key_pressed(KEY_2)):
		complete_task(1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
