extends CharacterBody2D
var direction = 0
func _ready():
	$Timer.start()
	var parent = get_node_or_null("..") 
	direction = parent.direction
	$Area2D/CollisionShape2D.set_deferred("disabled",true)
	velocity.x = 0
func _process(delta):
	var parent = get_node_or_null("..")
	if $Area2D/RayCast2DLeft.is_colliding() or $Area2D/RayCast2DRight.is_colliding():
		queue_free()
	moverse(direction)

	move_and_slide()

func moverse(direction):
	velocity.x = direction * 300
	



func _on_dmg_player_he_hecho_danio():
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
	$Area2D/CollisionShape2D.set_deferred("disabled",false)


func _on_timer_timeout():
	queue_free()
	
func takeDmg(damage):
	queue_free()
