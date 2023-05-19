extends PlayerState
var empuje = false
var lado = 0
func state_enter_state(msg := {}):
	$Timer.start()
	lado = msg.get("Lado")
	if msg.has("Empuje"):
		empuje = true
	anim_player.play("herido")
	await $"../../AnimationPlayer".animation_finished
	
	player.dmgColision.set_deferred("disabled",true)
	$"../../AudioHerirse".play()
	player.velocity.y = - player.jump - 100
	player.move_and_slide()

func state_physics_process(delta):
	if empuje:
		player.move_and_slide()
	elif !empuje:
		var direccion = Input.get_axis("ui_left","ui_right")
		player.sprite.flip_h = direccion < 0 if direccion != 0 else player.sprite.flip_h
		player.velocity.x = direccion * player.speed
		player.velocity.y += player.gravity
		player.move_and_slide()


func _on_timer_timeout():
	state_machine.transition_to("Idle")
	player.dmgColision.set_deferred("disabled",false)
	empuje = false
	

