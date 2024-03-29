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

func _process(delta):
	for s in subscriptions:
		s.update(delta);

func remove_sub(id : int):
	for s in subscriptions:
		if id != s.id: continue;
		subscriptions.erase(s);
		return true;
	print("couldn't find");
	return false;
