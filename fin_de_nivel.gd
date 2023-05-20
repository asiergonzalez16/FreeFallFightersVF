extends Area2D

@export var siguienteNivel: String




func _on_body_entered(body):
	if body is Player:
		Global.inicio = true
		Global.unlockLevels+=1
		Save.game_data.levels_unlocked += 1
		Save.save_data()
		body.transition_to_scene(siguienteNivel)
