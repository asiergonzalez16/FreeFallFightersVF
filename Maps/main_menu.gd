extends Node
@onready var settings_canvas_layer = $SettingsCanvasLayer


func _ready():
	settings_canvas_layer.hide()
	pass

func _process(delta):
	pass



func _on_start_pressed():
	get_tree().change_scene_to_file("res://Player/world.tscn")

func _on_exit_pressed():
	get_tree().quit()




func _on_settings_pressed():
	settings_canvas_layer.show()
	pass # Replace with function body.
