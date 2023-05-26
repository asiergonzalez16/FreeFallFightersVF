extends PlayerState

var canChangeState = false
var direction : float

func state_enter_state(msg :={}):
	canChangeState = false
	direction = Input.get_axis("ui_left","ui_right")
	player.velocity = Vector2.ZERO
	
func state_physics_process(delta):
	player.velocity.y = lerpf(player.velocity.y,- player.jump,.9) #update the velocity vertical of the player using the value of the jump "-player.jump" using interpolation lineal
	player.velocity.x = lerpf(player.velocity.x,- direction * player.jump,.9) #update the velocity horizontal of the player using the value of the jump "-player.jump" using interpolation lineal
	
	if player.velocity.y == -player.jump: #if the velocity in vertical is the name es player.jump means can change to enAire
		canChangeState = true
	player.move_and_slide()
	
	if canChangeState and !player.is_on_floor(): #if player still on the air and the velocity vertical is the same as player.jump
		state_machine.transition_to("enAire") #change scene to enAire
	elif player.is_on_ceiling():
		state_machine.transition_to("enAire")
#	elif Input.is_action_just_pressed("dash"):
#		state_machine.transition_to("dash")
