extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player") and Global.flag: #if the body enter on the area is a Player and is the first time enter
		$AnimationPlayer.play("idle") #play the animation of the flag
		Global.checkX = position.x
		Global.checkY = position.y
		Global.start = false 
		Global.flag = false #making this variable false, we stop the loop for animation everytime it enter area.

