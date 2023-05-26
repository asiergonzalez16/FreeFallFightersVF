extends PlayerState
var push = false
var drag = false
var side = 0
var Dx = 0 
var Dy = 0
var leftovers = 0
func state_enter_state(msg := {}):
	$Timer.start()
	
	if msg.has("Empuje"): #If the missage in dictionary has "Empuje"
		push = true
		side = msg.get("Lado")
	elif msg.has("Arrastrar"): #If the missage in dictionary has "Arrastrar"
		drag = true
		Dx = msg.get("dx")
		Dy = msg.get("dy")
		leftovers = msg.get("sobrante")
		
	anim_player.play("herido")
	await $"../../AnimationPlayer".animation_finished
	
	player.dmgColision.set_deferred("disabled",true)
	$"../../AudioHerirse".play() #play sound of injured
	player.velocity.y = - player.jump - 100
	player.move_and_slide()

func state_physics_process(delta):
	if push:
		player.velocity.x = side * 300
		player.move_and_slide()
	elif drag:
		if player.rayDown.is_colliding() and Dy == 1:
			player.morir()
		if player.rayUp.is_colliding() and Dy == -1:
			player.morir()
		if player.rayLeft.is_colliding() and Dx == -1:
			player.morir()
		if player.rayRight.is_colliding() and Dx == 1:
			player.morir()
		if Dx == -1 and player.rayDown.is_colliding():
			player.global_position.x = player.global_position.x - leftovers
		elif Dx == 1 and player.rayDown.is_colliding():
			player.global_position.x = player.global_position.x + leftovers
	else:
		var direction = Input.get_axis("ui_left","ui_right")
		player.sprite.flip_h = direction < 0 if direction != 0 else player.sprite.flip_h
		player.velocity.x = direction * player.speed
		player.velocity.y += player.gravity
		player.move_and_slide()


func _on_timer_timeout(): 
	state_machine.transition_to("Idle")
	player.dmgColision.set_deferred("disabled",false)
	push = false
	drag = false
	

