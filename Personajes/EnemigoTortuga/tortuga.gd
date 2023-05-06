extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var raySideLeft = $Raycast/RayCast2DSideLeft
@onready var raySideRight = $Raycast/RayCast2DSideRight
@onready var rayUpLeft = $Raycast/RayCast2DUpLeft
@onready var rayUpRight = $Raycast/RayCast2DUpRight
@onready var raycast = $Raycast

var vida := 2




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
				$ActivarSpikes.start()
				player = colision
				estadoActual = estados.ACTIVARSPIKES
				$Sprite2DIdle1.hide()
				$Sprite2DSpikesOut.show()
				animation_player.play("spikesOut")
				await(animation_player.animation_finished)
				estadoActual = estados.REPOSO2
				$dmgPlayer/CollisionShape2D.set_deferred("disabled",false)
				$CollisionShape2D.set_deferred("disabled",true)
				$Sprite2DSpikesOut.hide()
				$Sprite2DIdel2.show()
				animation_player.play("idle2")
			
			
func takeDmg(damage):
	vida -= damage
	print (vida)
	if vida <= 0:
		estadoActual = estados.MORIR
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		$Sprite2DIdel2.hide()
		$Sprite2DIdle1.hide()
		$Sprite2DSpikesIn.hide()
		$Sprite2DSpikesOut.hide()
		$Sprite2DHurt.show()
		animation_player.play("hurt")
		await (animation_player.animation_finished)
		$CollisionShape2D.set_deferred("disabled",true)
		
		queue_free()
	else:
		animation_player.play("hurt")
		await (animation_player.animation_finished)



func _on_activar_spikes_timeout():
	$Sprite2DIdel2.hide()
	$Sprite2DSpikesIn.show()
	animation_player.play("spikesIn")
	await(animation_player.animation_finished)
	estadoActual = estados.REPOSO
	$CollisionShape2D.set_deferred("disabled",false)
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
	$Sprite2DSpikesIn.hide()
	$Sprite2DIdle1.show()
	animation_player.play("idle1")
	$DesactivarSpikes.start()

	


func _on_desactivar_spikes_timeout():
	player = null
	
