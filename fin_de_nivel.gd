extends Area2D

@export var siguienteNivel: String

func _on_body_entered(body):
	Global.actualPointsLevel1 += int(Global.tiempo)
	Global.actualPointsLevel2 += int(Global.tiempo)
	Global.actualPointsLevel3 += int(Global.tiempo)
	if body is Player:
		if Global.ultimoBotonPressed == 1:
			Save.game_data.levels_unlocked = 2
			Save.save_data()
		elif Global.ultimoBotonPressed == 2:
			Save.game_data.levels_unlocked = 3
			Save.save_data()
		
		
		if Global.ultimoBotonPressed == 1 and Global.actualPointsLevel1 > Save.game_data.topScoreLevel1:
			Save.game_data.topScoreLevel1 = Global.actualPointsLevel1
			Save.save_data()
			
		elif Global.ultimoBotonPressed == 2 and Global.actualPointsLevel2 > Save.game_data.topScoreLevel2:
			Save.game_data.topScoreLevel2 = Global.actualPointsLevel2
			Save.save_data()
		elif Global.ultimoBotonPressed == 3 and Global.actualPointsLevel3 > Save.game_data.topScoreLevel3:
			Save.game_data.topScoreLevel3 = Global.actualPointsLevel3
			Save.save_data()
		
		Global.actualPointsLevel1 = 0
		Global.actualPointsLevel2 = 0
		Global.actualPointsLevel3 = 0
		Global.tiempo = 300
		Global.inicio = true
		body.transition_to_scene(siguienteNivel)
