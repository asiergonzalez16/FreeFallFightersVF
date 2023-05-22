extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player") and Global.flag:
		$AnimationPlayer.play("idle")
		Global.checkX = position.x
		Global.checkY = position.y
		Global.start = false
		Global.flag = false

