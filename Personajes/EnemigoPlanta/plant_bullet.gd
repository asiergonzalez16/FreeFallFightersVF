extends CharacterBody2D
var direccion = 0
func _ready():
	$Timer.start()
	var parent = get_node_or_null("..") 
	direccion = parent.direccion
	$Area2D/CollisionShape2D.set_deferred("disabled",true)
	velocity.x = 0
func _process(delta):
	var parent = get_node_or_null("..")
	if $Area2D/RayCast2DLeft.is_colliding() or $Area2D/RayCast2DRight.is_colliding():
		queue_free()
	moverse(direccion)

	move_and_slide()

func moverse(direccion):
	velocity.x = direccion * 250
	



func _on_dmg_player_he_hecho_danio():
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
	$Area2D/CollisionShape2D.set_deferred("disabled",false)


func _on_timer_timeout():
	queue_free()
	
func takeDmg(damage):
	queue_free()
