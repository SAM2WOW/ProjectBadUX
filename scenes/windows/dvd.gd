extends "res://scenes/window.gd"

var velocity = Vector2(200, 200)  # Initial velocity
var sprite_size = Vector2.ZERO

func _ready():
    # Get the size of the sprite
    sprite_size = get_size()

func _process(delta):
    # Move the DVD logo
    position = Vector2i(Vector2(position) + velocity * delta * 2)
    
    # Get the screen size
    var screen_size = DisplayServer.window_get_size()
    
    # Check collision with screen borders, considering sprite size
    if position.x < 0 or position.x > screen_size.x - sprite_size.x:
        velocity.x *= -1  # Reverse horizontal velocity on collision with left or right border
    if position.y < 0 or position.y > screen_size.y - sprite_size.y:
        velocity.y *= -1  # Reverse vertical velocity on collision with top or bottom border
