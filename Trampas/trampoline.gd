extends Area2D

var canBoost = true


func _on_body_entered(body):
	if body is Player:
		if canBoost:
			body.state_machine.transition_to("enAire",{Trampoline = true})
			canBoost = false
		$Idle.hide()
		$jump.show()
		$AnimationPlayer.play("jump")
		await $AnimationPlayer.animation_finished
		$jump.hide()
		canBoost = true
		$Idle.show()
