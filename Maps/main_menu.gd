extends Node
@onready var settings_canvas_layer = $SettingsCanvasLayer


func _ready():
	settings_canvas_layer.hide()
	var nivelesDesbloqueados = Save.game_data.levels_unlocked
	
	for i in range($levels.get_child_count()): #Contamos y buscamos cuantos niveles hay en total
		Global.levels.append(i+1)
	
	for level in $levels.get_children():
		if str_to_var(level.name) in range(nivelesDesbloqueados+1):
			level.disabled = false
		else:
			level.disabled = true
			
func _process(delta):
	pass


func _on_exit_pressed():
	get_tree().quit()




func _on_settings_pressed():
	settings_canvas_layer.show()
	pass # Replace with function body.



func _on_2_pressed():
	get_tree().change_scene_to_file("res://Player/world_2.tscn")


func _on_1_pressed():
	get_tree().change_scene_to_file("res://Player/world.tscn")


func _on_3_pressed():
	get_tree().change_scene_to_file("res://Maps/main_menu.tscn")


func _on_texture_button_pressed():
	settings_canvas_layer.show()


func _on_texture_button_2_pressed():
	get_tree().quit()
