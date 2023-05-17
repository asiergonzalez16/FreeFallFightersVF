extends Node


func _on_area_welcome_body_entered(body):
	if body is Player:
		$WelcomePopUp.show()
		$WelcomePopUp/Panel/AnimationPlayer.play("popup")



func _on_area_jump_body_entered(body):
	if body is Player:
		$JumpPopUp.show()
		$JumpPopUp/Panel/AnimationPlayer.play("popup")
		$WelcomePopUp.hide()


func _on_texture_button_pressed():
	$WelcomePopUp.hide()


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
	$CerditoPopUp.hide()
	$WallJumpPopUp.hide()
	$DoubleJumpPopUp.hide()
	$JumpPopUp.hide()
	$WelcomePopUp.hide()


func _on_cerdito_pop_up_body_entered(body):
	if body is Player:
		$WallJumpPopUp.hide()
		$CerditoPopUp.show()
		$CerditoPopUp2/Panel/AnimationPlayer.play("popup")
