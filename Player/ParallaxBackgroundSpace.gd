extends ParallaxBackground

@export var scrolling_speed = 20

func _process(delta):
	scroll_base_offset.x -= scrolling_speed + delta
