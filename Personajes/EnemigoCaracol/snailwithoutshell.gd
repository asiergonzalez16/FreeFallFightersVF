extends CharacterBody2D

var gravity = 9
var direccion = -1
var speed = 3


func _physics_process(delta):
	velocity.y += gravity
	velocity.x = 0
	move_and_slide()




