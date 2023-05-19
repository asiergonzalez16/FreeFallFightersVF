extends PlayerState
var empuje = false
var arrastrar = false
var lado = 0
var Dx = 0 
var Dy = 0
var sobrante = 0
func state_enter_state(msg := {}):
	$Timer.start()
	
	if msg.has("Empuje"):
		empuje = true
		lado = msg.get("Lado")
	elif msg.has("Arrastrar"):
		arrastrar = true
		Dx = msg.get("dx")
		Dy = msg.get("dy")
		sobrante = msg.get("sobrante")
		
	anim_player.play("herido")
	await $"../../AnimationPlayer".animation_finished
	
	player.dmgColision.set_deferred("disabled",true)
	$"../../AudioHerirse".play()
	player.velocity.y = - player.jump+100
	player.move_and_slide()

func state_physics_process(delta):
	if empuje:
		player.velocity.x = lado * 250
		player.move_and_slide()
	elif arrastrar:
		print(Dx)
		print(Dy)
		if player.rayDown.is_colliding() and Dy == 1:
			player.morir()
		if player.rayUp.is_colliding() and Dy == -1:
			player.morir()
		if player.rayLeft.is_colliding() and Dx == -1:
			player.morir()
		if player.rayRight.is_colliding() and Dx == 1:
			player.morir()
		if Dx == -1:
			player.global_position.x = player.global_position.x - sobrante
		elif Dx == 1:
			player.global_position.x = player.global_position.x + sobrante
	else:
		var direccion = Input.get_axis("ui_left","ui_right")
		player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
		player.velocity.x = direccion * player.speed
		player.velocity.y += player.gravity
		player.move_and_slide()


func _on_timer_timeout():
	state_machine.transition_to("Idle")
	player.dmgColision.set_deferred("disabled",false)
	empuje = false
	arrastrar = false
	

