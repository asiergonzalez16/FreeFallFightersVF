extends Node
@onready var settings_canvas_layer = $SettingsCanvasLayer

func _ready():
	settings_canvas_layer.hide()
	$"levels/1/Label".text = str(Save.game_data.topScoreLevel1)
	$"levels/2/Label".text = str(Save.game_data.topScoreLevel2)
	$"levels/3/Label".text = str(Save.game_data.topScoreLevel3)
	
	var nivelesDesbloqueados = Save.game_data.levels_unlocked
	if nivelesDesbloqueados >= 3:
		$Imagenes/level2locked.hide()
		$Imagenes/level3locked.hide()
	else:
		if nivelesDesbloqueados == 2:
			$Imagenes/level2locked.hide()
		elif nivelesDesbloqueados == 3:
			$Imagenes/level2locked.hide()
			$Imagenes/level3locked.hide()
		
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
	Global.ultimoBotonPressed = 2
	get_tree().change_scene_to_file("res://Player/world.tscn")


func _on_1_pressed():
	Global.ultimoBotonPressed = 1
	get_tree().change_scene_to_file("res://Player/world_tutorial.tscn")


func _on_3_pressed():
	Global.ultimoBotonPressed = 3
	get_tree().change_scene_to_file("res://Player/world_2.tscn")


func _on_texture_button_pressed():
	settings_canvas_layer.show()


func _on_texture_button_2_pressed():
	get_tree().quit()


const SAVEFILE = "user://SAVEFILE.save"
func _on_reset_game_pressed():
	$levels.hide()
	$Imagenes.hide()
	$Control.show()
	$Control/Panel/AnimationPlayer.play("popup")


func _on_borrar_todo_pressed():
	var dir = DirAccess.remove_absolute(SAVEFILE)
	get_tree().quit()


func _on_me_lo_he_pensado_mejor_pressed():
	$Control.hide()
	$levels.show()
	$Imagenes.show()


func _on_texture_rect_mouse_entered():
	$"levels/1/Label".show()


func _on_texture_rect_mouse_exited():
	$"levels/1/Label".hide()


func _on_level_2_record_mouse_entered():
	$"levels/2/Label".show()


func _on_level_2_record_mouse_exited():
	$"levels/2/Label".hide()


func _on_level_3_record_mouse_entered():
	$"levels/3/Label".show()


func _on_level_3_record_mouse_exited():
	$"levels/3/Label".hide()
