extends "res://scenes/window.gd"


var ads = [
	"res://arts/ads/OIG2 (1).jpg",
	"res://arts/ads/OIG2..jpg",
	"res://arts/ads/OIG2.jpg",
	"res://arts/ads/RRp6pTrYz29gqeSS9frXaeWfkW3DSdFedc6sdMVdciA.webp",
	"res://arts/ads/ZPVYdXk.jpeg",
	"res://arts/ads/images (1).jpg",
	"res://arts/ads/images.jpg",
	"res://arts/ads/aiads (1).jpg",
	"res://arts/ads/aiads (2).jpg",
	"res://arts/ads/aiads (3).jpg",
	"res://arts/ads/aiads (4).jpg",
]

func _process(delta):
	if $AudioStreamPlayer.is_playing():
		position += Vector2i(randi_range(-1,1),randi_range(-1,1))

func _ready():
	super._ready()
	
	var texture = load(ads[randi() % ads.size()])
	$Control/TextureRect.set_texture(texture)
	window_icon = texture
	
	var screen_size = DisplayServer.window_get_size()
	
	# Get random position within screen size
	var random_x = randi_range(0, screen_size.x - size.x)
	var random_y = randi_range(0, screen_size.y - size.y)
	
	position = (Vector2i(random_x, random_y))



func _on_video_stream_player_finished():
	Global.windowsManager.remove_window(self)
	queue_free()


func _on_timer_timeout():
	$Control/Button.show()
