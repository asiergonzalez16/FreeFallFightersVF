extends CharacterBody2D

var gravity = 9
var direccion = 3
var speed = 3

func _process(delta):
	position.y +=3
	move_and_slide()



