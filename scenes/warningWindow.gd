extends Control
class_name WarningWindow;

@export var warningList : Dictionary;
var warningQueue : Array;
var initialPos;

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.warningWindow = self;
	visible = false;
	initialPos = position.y;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if (Input.is_key_pressed(KEY_3)):
		AddWarning(0);
	if (Input.is_key_pressed(KEY_3)):
		AddWarning(1);
		
func AddWarning(id : int):
	if !warningList.has(id):
		print("warning id %d not found" % id);
		return;
	elif warningQueue.has(id):
		print("stop from re-adding existing warning %d to the queue" % id);
		return;
	warningQueue.push_back(id);
	print(warningQueue)
	if warningQueue.size() == 1:
		_ShowWarning();
	
func _ShowWarning():
	if warningQueue.is_empty(): return;
	var id = warningQueue[0];
	print(id);
	if id == null: return;
	for warningId in warningList:
		if id != warningId: continue;
		SetDescription(warningList[id]);
	await WindowDisplayRoutine();
	warningQueue.pop_front();
	_ShowWarning();
	

func SetDescription(newDesc : String):
	$ColorRect/Description.clear();	
	$ColorRect/Description.add_text(newDesc);

func WindowDisplayRoutine():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT);
	var posShift = size.y;
	set_position(Vector2(position.x, 50));
	visible = true;
	tween.tween_property(self, "position", Vector2(position.x, initialPos), 1);
	await get_tree().create_timer(6).timeout;
	tween = create_tween().set_trans(Tween.TRANS_EXPO);
	tween.tween_property(self, "position", Vector2(position.x, 50), 1);
	await get_tree().create_timer(1).timeout;
	visible=false;
