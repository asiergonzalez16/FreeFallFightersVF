extends Node


func _ready():
	pass

func _process(delta):
	pass



func _on_start_pressed():
	get_tree().change_scene_to_file("res://Player/world.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_full_screen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
