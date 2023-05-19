extends Area2D

var puedeImpulsar = true


func _on_body_entered(body):
	if body is Player:
		if puedeImpulsar:
			body.state_machine.transition_to("enAire",{Trampoline = true})
			puedeImpulsar = false
		$Idle.hide()
		$jump.show()
		$AnimationPlayer.play("jump")
		await $AnimationPlayer.animation_finished
		$jump.hide()
		puedeImpulsar = true
		$Idle.show()
