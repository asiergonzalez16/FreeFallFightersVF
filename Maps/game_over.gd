extends Node



func _on_button_pressed(): #When pressed button, go to main menu scene
	get_tree().change_scene_to_file("res://Maps/main_menu.tscn")
