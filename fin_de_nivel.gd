extends Area2D

@export var nextLevel: String

func _on_body_entered(body):
	#Update the actualPoints by adding the time
	Global.actualPointsLevel1 += int(Global.time)
	Global.actualPointsLevel2 += int(Global.time)
	Global.actualPointsLevel3 += int(Global.time) 
	
	if body is Player:
		if Global.lastButtonPressed == 1: #if level succesfull was 1, we unlock the second
			Save.game_data.levels_unlocked = 2
			Save.save_data()
		elif Global.lastButtonPressed == 2: #if the level succesfull is 2, we unlock the third level
			Save.game_data.levels_unlocked = 3
			Save.save_data()
		
		
		if Global.lastButtonPressed == 1 and Global.actualPointsLevel1 > Save.game_data.topScoreLevel1:
			Save.game_data.topScoreLevel1 = Global.actualPointsLevel1 #if actualpoints are higher than the topscore, we update values of the level
			Save.save_data()
			
		elif Global.lastButtonPressed == 2 and Global.actualPointsLevel2 > Save.game_data.topScoreLevel2:
			Save.game_data.topScoreLevel2 = Global.actualPointsLevel2 #if actualpoints are higher than the topscore, we update values of the level
			Save.save_data()
		elif Global.lastButtonPressed == 3 and Global.actualPointsLevel3 > Save.game_data.topScoreLevel3:
			Save.game_data.topScoreLevel3 = Global.actualPointsLevel3 #if actualpoints are higher than the topscore, we update values of the level
			Save.save_data()
		
		Global.actualPointsLevel1 = 0 #reset all points on 0 after end a level
		Global.actualPointsLevel2 = 0 #reset all points on 0 after end a level
		Global.actualPointsLevel3 = 0 #reset all points on 0 after end a level
		Global.time = 300 #reset the time on 300
		Global.start = true #make variable start on true, if its true, it means there is no checkpoint cause we end level
		body.transition_to_scene(nextLevel)
