extends CharacterBody2D

@onready var anim = $AnimationPlayer
var counter = 0

func _ready():
	$AnimationPlayer.play("on")


func _on_timer_timeout(): #after timer ends, the platform will pretend to fall down 3 times, after this, delete platform
	global_position.y = global_position.y + 5
	counter +=1
	
	if counter >= 3:
		queue_free()
#	$Area2D/CollisionShape2D.disabled = true
#	$CollisionShape2D.disabled = true
	

func _on_area_2d_body_entered(body): 
	if body is Player: #if player entered on area, start timer, play animation of broken platform
		$Timer.start()
		anim.play("off")
		$AnimationPlayer.play("off")
