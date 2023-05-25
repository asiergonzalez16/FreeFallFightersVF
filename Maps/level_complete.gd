extends CanvasLayer

func _ready():
	pass

func _process(delta):
	if Global.lastButtonPressed == 1:
		$Control/MarginContainer/VBoxContainer/Current.text = "Current Score: " + str(Global.actualPointsLevel1)
		$Control/MarginContainer/VBoxContainer/Top.text = "Top Score: " + str(Save.game_data.topScoreLevel1)
	elif Global.lastButtonPressed == 2:
		$Control/MarginContainer/VBoxContainer/Current.text = "Current Score: " + str(Global.actualPointsLevel2)
		$Control/MarginContainer/VBoxContainer/Top.text = "Top Score: " + str(Save.game_data.topScoreLevel2)
	elif Global.lastButtonPressed == 3:
		$Control/MarginContainer/VBoxContainer/Current.text = "Current Score: " + str(Global.actualPointsLevel3)
		$Control/MarginContainer/VBoxContainer/Top.text = "Top Score: " + str(Save.game_data.topScoreLevel3)



func _on_try_again_pressed():
	Global.fruits = 0
	Global.flag = true
	Global.start = true
	Global.continuePointing = true
	Global.time = 300
	get_tree().reload_current_scene()


func _on_continue_pressed():
	Global.fruits = 0
	Global.start = true
	get_tree().change_scene_to_file("res://Maps/main_menu.tscn")
