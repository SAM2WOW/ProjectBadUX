extends TextureButton
var timerText : Label;
var timer : float = 59;

# Called when the node enters the scene tree for the first time.
func _ready():
	timerText = $ColorRect/VBoxContainer/MarginContainer/ColorRect/TimerText;
	timerText.text = "00:%d" % int(timer);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta;
	if timer < 0: timer = 59;
	if int(ceil(timer)) >= 10:
		timerText.set("theme_override_colors/font_color",Color.WHITE);
		timerText.text = "00:%d" % int(ceil(timer));
	else:
		timerText.set("theme_override_colors/font_color",Color.RED);
		timerText.text = "00:0%d" % int(ceil(timer));
