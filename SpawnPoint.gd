extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player") and Global.bandera:
		Global.checkX = position.x
		Global.checkY = position.y
		$AnimationPlayer.play("idle")
		Global.inicio = false
		Global.bandera = false

