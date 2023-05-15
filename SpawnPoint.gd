extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player") and Global.bandera:
		$AnimationPlayer.play("idle")
		Global.checkX = position.x
		Global.checkY = position.y
		Global.inicio = false
		Global.bandera = false

