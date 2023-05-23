extends Area2D

func _on_body_entered(body): #if entity fall to the end of map, we call method morir of the entity
	if body is Player:
		body.morir()
