extends Node

func _ready():
	pass

func _on_area_welcome_body_entered(body): #Show the popup and play the animation
	if body is Player:
		$WelcomePopUp.show()
		$WelcomePopUp/Panel/AnimationPlayer.play("popup")



func _on_area_jump_body_entered(body): #Show the popup and play the animation, hide the welcome popup
	if body is Player:
		$JumpPopUp.show()
		$JumpPopUp/Panel/AnimationPlayer.play("popup")
		$WelcomePopUp.hide()


func _on_texture_button_pressed(): #if button X is pressed, the popup close
	$WelcomePopUp.hide()

#The rest methods are the same with more popups
func _on_area_doble_jump_body_entered(body):
	if body is Player:
		$DoubleJumpPopUp.show()
		$DoubleJumpPopUp/Panel/AnimationPlayer.play("popup")
		$WelcomePopUp.hide()
		$JumpPopUp.hide()

func _on_boton_finalizar_pressed():
	$JumpPopUp.hide()


func _on_close_pop_up_pressed():
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()

func _on_close_pop_up_wall_pressed():
	$WallJumpPopUp.hide()
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()


func _on_wall_jump_body_entered(body):
	if body is Player:
		$DoubleJumpPopUp.hide()
		$WallJumpPopUp.show()
		$WallJumpPopUp/Panel/AnimationPlayer.play("popup")


func _on_close_cerdito_pressed():
	$CerditoPopUp2.hide()
	$WallJumpPopUp.hide()
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()


func _on_cerdito_pop_up_body_entered(body):
	if body is Player:
		$WallJumpPopUp.hide()
		$CerditoPopUp2.show()
		$CerditoPopUp2/Panel/AnimationPlayer.play("popup")


func _on_frutas_letrero_body_entered(body):
	if body is Player:
		$FrutasPopUp2.show()
		$CerditoPopUp2.hide()
		$FrutasPopUp2/Panel/AnimationPlayer.play("popup")


func _on_close_frutas_pressed():
	$FrutasPopUp2.hide()
	$CerditoPopUp2.hide()
	$WallJumpPopUp.hide()
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()


func _on_close_esc_pop_up_pressed():
	$PauseMenuPopUp.hide()
	$FrutasPopUp2.hide()
	$CerditoPopUp2.hide()
	$WallJumpPopUp.hide()
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()


func _on_esc_letero_body_entered(body):
	if body is Player:
		$PauseMenuPopUp.show()
		$FrutasPopUp2.hide()
		$PauseMenuPopUp/Panel/AnimationPlayer.play("popup")
