extends Resource
class_name Subscription;

@export var id : int = 0;
@export var tickRate : float = 2;
@export var damagePerTick : float = 2;

var tickTimer = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	tickTimer = tickRate;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(delta):
	tickTimer += delta;
	if tickTimer >= tickRate:
		tickTimer -= tickRate;
		if Global.healthBar != null: 
			Global.healthBar.call_deferred("take_damage", damagePerTick, "Don't forget your subscriptions!")
