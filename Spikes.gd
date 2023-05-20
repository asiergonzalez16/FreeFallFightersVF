extends Area2D


func _on_body_entered(body):
	if body is Player:
		body.velocity.y = -body.jump+20
		body.takeDamage(1)
		
