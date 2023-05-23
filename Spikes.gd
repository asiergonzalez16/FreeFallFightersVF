extends Area2D


func _on_body_entered(body): # if player colision with spikes area, player jump and take damage
	if body is Player:
		body.velocity.y = -body.jump+20 
		body.takeDamage(1)
		
