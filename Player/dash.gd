extends PlayerState

var dashSpeed = 400
var direccionDash = 1
func state_enter_state(msg := {}):
	player.canDash = false
	player.velocity.y = Input.get_axis("ui_up","ui_down") * dashSpeed
	player.velocity.x = Input.get_axis("ui_left","ui_right") * dashSpeed
	$DashTimer.start()
	
#	if $"../../Sprite2D".flip_h:
#		direccionDash = -1
#	else:
#		direccionDash = 1
func state_physics_process(delta):
#	player.velocity.x = direccionDash * dashSpeed
	player.move_and_slide()


func _on_dash_timer_timeout():
	state_machine.transition_to("Idle")
