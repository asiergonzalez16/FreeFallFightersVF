extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var raySideLeft = $Raycast/RayCast2DSideLeft
@onready var raySideRight = $Raycast/RayCast2DSideRight
@onready var rayUpLeft = $Raycast/RayCast2DUpLeft
@onready var rayUpRight = $Raycast/RayCast2DUpRight
@onready var raycast = $Raycast

var vida := 1




enum estados {REPOSO,ACTIVARSPIKES,REPOSO2,DESACTIVARSPIKES,MORIR}
var player
var estadoActual = estados.REPOSO

func _ready():
	animation_player.play("idle1")
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)

func _process(delta):
	for ray in raycast.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				animation_player.play("spikesOut")
				await(animation_player.animation_finished)
				$dmgPlayer/CollisionShape2D.set_deferred("disabled",false)
				$ActivarSpikes.start()
				player = colision
				estadoActual = estados.ACTIVARSPIKES
				estadoActual = estados.REPOSO2
				animation_player.play("idle2")
			
			
func takeDmg(damage):
	if $dmgPlayer/CollisionShape2D.disabled == true:
		vida -= damage
		animation_player.play("hurt")
		await (animation_player.animation_finished)
		if vida <= 0:
			estadoActual = estados.MORIR
			$CollisionShape2D.set_deferred("disabled",true)
			$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
			queue_free()




func _on_activar_spikes_timeout():
	animation_player.play("spikesIn")
	await(animation_player.animation_finished)
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
	estadoActual = estados.REPOSO
	animation_player.play("idle1")
	$DesactivarSpikes.start()

	


func _on_desactivar_spikes_timeout():
	player = null
	
