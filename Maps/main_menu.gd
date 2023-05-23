extends Node
@onready var settings_canvas_layer = $SettingsCanvasLayer

func _ready():
	settings_canvas_layer.hide() #hide the settings, only show when pressed on the button
	#Add the max score on the label
	$"levels/1/Label".text = str(Save.game_data.topScoreLevel1)
	$"levels/2/Label".text = str(Save.game_data.topScoreLevel2)
	$"levels/3/Label".text = str(Save.game_data.topScoreLevel3)
	
	var unlockedLevels = Save.game_data.levels_unlocked #check the unlocked levels in the save file
	#Now we check depending the unlocked levels, we show an image locked or not
	if unlockedLevels >= 3:
		$Imagenes/level2locked.hide()
		$Imagenes/level3locked.hide()
	else:
		if unlockedLevels == 2:
			$Imagenes/level2locked.hide()
		elif unlockedLevels == 3:
			$Imagenes/level2locked.hide()
			$Imagenes/level3locked.hide()
		
	for i in range($levels.get_child_count()): #Count and check all buttons andsave in a variable
		Global.levels.append(i+1)
	
	for level in $levels.get_children(): #check all levels childrens of scene
		if str_to_var(level.name) in range(unlockedLevels+1): #check the unlocked levels and depending on it, disable or not the buttons
			level.disabled = false
		else:
			level.disabled = true
			
func _process(delta):
	pass


func _on_exit_pressed(): #close the game
	get_tree().quit()




func _on_settings_pressed(): #button pressed show the settings
	settings_canvas_layer.show()
	pass # Replace with function body.



func _on_2_pressed(): #go to level 2
	Global.lastButtonPressed = 2
	get_tree().change_scene_to_file("res://Player/world.tscn")


func _on_1_pressed(): #go to level 1
	Global.lastButtonPressed = 1
	get_tree().change_scene_to_file("res://Player/world_tutorial.tscn")


func _on_3_pressed(): #go to level 3
	Global.lastButtonPressed = 3
	get_tree().change_scene_to_file("res://Player/world_2.tscn")


func _on_texture_button_pressed(): #show settings
	settings_canvas_layer.show()


func _on_texture_button_2_pressed(): #close the game
	get_tree().quit()


const SAVEFILE = "user://SAVEFILE.save"
func _on_reset_game_pressed(): #when button for reset is preseed, we hide all and play a pop-up
	$levels.hide()
	$Imagenes.hide()
	$Control.show()
	$Control/Panel/AnimationPlayer.play("popup")


func _on_borrar_todo_pressed(): #Button pressed for reset all in the popup, we remove the file save.
	var dir = DirAccess.remove_absolute(SAVEFILE)
	get_tree().quit()


func _on_me_lo_he_pensado_mejor_pressed(): #return 
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
