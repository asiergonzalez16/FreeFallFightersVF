extends Area2D


func _on_body_entered(body):
	if body is Player or body.is_in_group("Enemigos"):
		body.morir()
