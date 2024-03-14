extends Control
class_name WarningWindow;

@export var warningList = {
	0: ["Watch out for websites that hide behind a false address!", 5],
	1: ["Ouch, you hit a real duck 😭.", 12],
	2: ["Oops wrong button!", 2],
	3: ["Oops! Watch out for suspicious ads.", 4],
	4: ["Oh no you deleted an important email 🙁.", 8],
	5: ["Careful not to click on scam email links.", 5],
	6: ["AI is getting really good at replicating things.", 12],
	7: ["You’re losing health, hurry and unsubscribe!", 10],
	8: ["Careful not to give out your personal information.", 1],
	9: ["Oops, looks like you made an unintended purchase.", 7],
	10: ["Stop those AI ducks before they fly out!", 12],
	11: ["Don't fall for these 🤭.", 6],
}

var warningQueue : Array;
var initialPos;

var warningWindow = preload("res://scenes/warningWindow.tscn")


func _ready():
	Global.warningWindow = self;
	visible = false;
	initialPos = position.y;


func _input(event):
	if (Input.is_key_pressed(KEY_3)):
		return
		AddWarning(0);

func AddWarning(id : int):
	var w = warningWindow.instantiate()
	w.SetDescription(warningList[id])
	w.set_position(Vector2i(1065, 602 - 10 * (get_child_count())))
	add_child(w)
	
	return
	# I'm ignoring all below stuffs
	
	"""
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
	"""

func _ShowWarning():
	if warningQueue.is_empty(): return;
	var id = warningQueue[0];
	print(id);
	if id == null: return;
	for warningId in warningList:
		if id != warningId: continue;
		#SetDescription(warningList[id]);
	await WindowDisplayRoutine();
	warningQueue.pop_front();
	_ShowWarning();


func WindowDisplayRoutine():
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT);
	var posShift = size.y;
	set_position(Vector2(position.x, 50));
	visible = true;
	tween.tween_property(self, "position", Vector2(position.x, initialPos), 1);
	$Timer.start();
	while !$Timer.is_stopped():
		await get_tree().process_frame;
	await close();


func close():
	print("close");
	var tween = create_tween().set_trans(Tween.TRANS_EXPO);
	tween.tween_property(self, "position", Vector2(position.x, 50), 1);
	await get_tree().create_timer(1).timeout;
	visible=false;


func _on_close_button_button_down():
	$Timer.stop();
