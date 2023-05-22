extends PlayerState


func state_enter_state(msg := {}):
	anim_player.play("walk")
	
func state_physics_process(delta):
	var direction = Input.get_axis("ui_left","ui_right")
	player.sprite.flip_h = direction < 0 if direction != 0 else player.sprite.flip_h
	
	player.velocity.x = direction * player.speed
	player.move_and_slide()
	
	if direction == 0:
		state_machine.transition_to("Idle")
	elif !player.is_on_floor():
		state_machine.transition_to("enAire") 
	elif Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("enAire",{Salto = true})
#	elif Input.is_action_just_pressed("dash") and player.canDash:
#		state_machine.transition_to("dash")
	
