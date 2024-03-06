extends Control

@export var taskList : Dictionary;
var taskNode = preload("res://scenes/windows/task.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	initiate_tasks();
	
func show_window():
	SoundPlayer.play("Confirm")
	visible = true;

func hide_window():
	SoundPlayer.play("Deny")
	visible = false;

func initiate_tasks():
	for task in taskList:
		var t = taskNode.instantiate();
		t.init_task(task, taskList[task]);
		$TaskContainer.add_child(t);

func complete_task(taskId : int):
	for task in $TaskContainer.get_children():
		if !task is Task || task.id != taskId: continue;
		task.finish_task();
	
func _input(ev):
	if (Input.is_key_pressed(KEY_2)):
		complete_task(1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass