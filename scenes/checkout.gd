extends Control
var itemContainer;
var ipText;
var ssnText;
var bankText;
var warningLabel;
var totalLabel;

# Called when the node enters the scene tree for the first time.
func _ready():
	itemContainer = $MarginContainer/VBoxContainer/ReviewItems/VBoxContainer/ItemContainer;
	ipText = $MarginContainer/VBoxContainer/PersonalInfo/VBoxContainer/HBoxContainer/MarginContainer2/VBoxContainer/IpAddress;
	ssnText = $MarginContainer/VBoxContainer/PersonalInfo/VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/SSNText;
	bankText = $MarginContainer/VBoxContainer/CardInfo/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/VBoxContainer/RoutingNumber;
	warningLabel = $HBoxContainer/VBoxContainer3/MarginContainer2/warningLabel;
	totalLabel = $HBoxContainer/VBoxContainer2/Label;
	init();

func init():
	warningLabel.visible = false;
	for c in itemContainer.get_children():
		if c is Item:
			c.init();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var total = 0.0;
	for c in itemContainer.get_children():
		if c is Item && c.active:
			total += 10;
	totalLabel.text = "Total: $%.*f" % [2, total];

func check_items():
	for c in itemContainer.get_children():
		if !c is Item: continue;
		if (!c.correctItem && c.active) || (c.correctItem && !c.active):
			return false;
	return true;

func check_information():
	if !ipText.text.is_empty() || !ssnText.text.is_empty() || !bankText.text.is_empty():
		return false;
	return true;

func show_error(text : String):
	$Timer.start();
	warningLabel.text = text;
	while !$Timer.is_stopped():
		warningLabel.visible = true;
		await get_tree().process_frame;
	warningLabel.visible = false;

func _on_confirm_button_down():
	if !check_items():
		show_error("You don't have the funds for this!");
		return;
		print("wrong items");
	else:
		print("correct items");
	if !check_information():
		show_error("Your information has been sold!");
		return;
		print("wrong info");
	else:
		print("correct info");