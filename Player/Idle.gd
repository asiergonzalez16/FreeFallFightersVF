extends PlayerState

func state_enter_state(msg := {}):
	player.velocity = Vector2.ZERO
	anim_player.play("idle") #animation play idle

func state_process(delta): #
	var direction = Input.get_axis("ui_left","ui_right") #check direction with the keys left or right, this is configured A-D keys too
	
	player.move_and_slide()
	
	if direction != 0: #If direction different 0 means than is on moving so we transition to
		state_machine.transition_to("Moving")
	elif !player.is_on_floor(): #If is not on the floor, we change state to "enAire"
		state_machine.transition_to("enAire")
	elif Input.is_action_just_pressed("ui_accept"): #If pressed on keyboard "space" we change to "enAire" 
		state_machine.transition_to("enAire",{Salto = true})
#	elif Input.is_action_just_pressed("dash") and player.canDash:
#		state_machine.transition_to("dash")
