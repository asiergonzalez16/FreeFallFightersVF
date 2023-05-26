extends PlayerState

var hasJumped = false
var isFalling = false

func state_enter_state(msg := {}): #this execute when we are in the air
	if msg.has("Salto"): #when we change to this state, we use a dictionary, if it contains the word "Salto" then:
		hasJumped = true
		player.numJumps-=1 
		$"../../AudioSalto".play() #play audio jump
		anim_player.play("jump") #animation for jump
		player.velocity.y = - player.jump +50
		if player.numJumps == 0: #if number of jump is 0 means he jumped 2 times, then we play doubleJump animation
			anim_player.play("doubleJump")

	elif msg.has("Trampoline"): #if the dictionary is Trampoline, we make the jump is higher
		hasJumped = true
		player.numJumps+=1
		$"../../AudioSalto".play()
		anim_player.play("jump")
		player.velocity.y = - player.jump - 400
	
		if player.numJumps == 0:
			anim_player.play("doubleJump")
		
	else: #if there is not this options, means is falling, then we play fall animation
		anim_player.play("fall")
	
	if isFalling:
		$CoyoteTimer.start()

func state_physics_process(delta):
	var direction = Input.get_axis("ui_left","ui_right")
	
	player.sprite.flip_h = direction < 0 if direction != 0 else player.sprite.flip_h
	
	player.velocity.x = direction * player.speed
	
	player.velocity.y += player.gravity
	
	if player.velocity.y > 0: #if the velocity.y is positive, means that is falling
		isFalling = true
	else:
		isFalling = false
	
	player.move_and_slide()
	
	if player.is_on_wall() and (player.rayRight.is_colliding() or player.rayLeft.is_colliding()):
		state_machine.transition_to("wallSlide") 
	
	if player.is_on_floor(): #if player is on floor, change to Idle state
		state_machine.transition_to("Idle")
	if !$BufferJumpTimer.is_stopped() and player.is_on_floor():
		$BufferJumpTimer.stop()
		player.reiniciaSaltos()
		state_machine.transition_to("enAire",{Salto = true})
	elif hasJumped and Input.is_action_just_pressed("ui_accept") and player.numJumps > 0:
		state_machine.transition_to("enAire",{Salto = true})
		hasJumped = false
	elif !$CoyoteTimer.is_stopped() and  Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("enAire",{Salto = true})
	elif Input.is_action_just_pressed("ui_accept"):
		$BufferJumpTimer.start()
#	elif Input.is_action_just_pressed("dash") and player.canDash:
#		state_machine.transition_to("dash")
		

func state_exit():
	pass
