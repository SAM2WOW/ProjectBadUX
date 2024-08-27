extends Node

var console
var windowsManager
var healthBar
var taskWindow
var warningWindow

var files = []

var crash_reason = ""
# healthBar.take_damage(num) to damage player
# taskWindow.complete_task(id) to complete task
# warningWindow.AddWarning(id) to show a warning

var subscriptions = []
var deleted_emails = []
var notepad_content = ""

var taskCompletion

var tickTimer = 0;
var tickRate : float = 2;
var damagePerTick : float = 2;

func _ready():
	tickTimer = tickRate;


func _process(delta):
	if not subscriptions.is_empty():
		tickTimer += delta;
		if tickTimer >= tickRate:
			tickTimer -= tickRate;
			if Global.healthBar != null: 
				Global.healthBar.call_deferred("take_damage", damagePerTick * subscriptions.size(), "Your uncancelled subscriptions got you!")
	
	#for s in subscriptions:
		#s.update(delta);


func remove_sub(id : int):
	# force remove just one anyway
	if not subscriptions.is_empty():
		subscriptions.pop_back()
		return
	return
	
	for s in subscriptions:
		if id != s.id: continue;
		subscriptions.erase(s);
		return true;
	print("couldn't find");
	return false;
