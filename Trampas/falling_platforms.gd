extends CharacterBody2D

@onready var anim = $AnimationPlayer
var contador = 0

func _ready():
	$AnimationPlayer.play("on")


func _on_timer_timeout():
	global_position.y = global_position.y + 5
	contador +=1
	
	if contador >= 4:
		queue_free()
#	$Area2D/CollisionShape2D.disabled = true
#	$CollisionShape2D.disabled = true
	

func _on_area_2d_body_entered(body):
	if body is Player:
		$Timer.start()
		anim.play("off")
		$AnimationPlayer.play("off")
