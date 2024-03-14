extends ProgressBar

var health : float = 100;
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.healthBar = self;
	value = health;

func take_damage(dmg : float):
	SoundPlayer.play("Damage")
	
	if health <= 0: return;
	health = max(health-dmg, 0);
	value = health;
	if health <= 0:
		game_over();
	
	modulate = Color("ff0004a6")
	$"../Timer".start()

func game_over():
	print("game over!");
	
	Global.crash_reason = "Fall for too many dark UX patterns..."
	get_tree().change_scene_to_file("res://levels/crashed.tscn")
	SoundPlayer.play("Crash")

func _input(ev):
	if Input.is_key_pressed(KEY_1):
		take_damage(10);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;


func _on_timer_timeout():
	modulate = Color.WHITE
