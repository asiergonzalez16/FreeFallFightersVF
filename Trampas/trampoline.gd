extends Area2D

var canBoost = true #we use this variable for avoid while doing one animation, jump again, only can jump 1 time until ends animation


func _on_body_entered(body):
	if body is Player:
		if canBoost:
			body.state_machine.transition_to("enAire",{Trampoline = true}) #change state to enAire and send on the dictionary Trampoline workd
			canBoost = false 
		$Idle.hide()
		$jump.show()
		$AnimationPlayer.play("jump") #play animation jump
		await $AnimationPlayer.animation_finished
		$jump.hide()
		canBoost = true
		$Idle.show()
