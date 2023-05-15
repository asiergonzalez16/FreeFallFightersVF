extends CharacterBody2D
var speed 
enum estados {REPOSO,WAKEUP}
var estadoActual = estados.REPOSO
var player
@onready var animation_player = $AnimationPlayer
@onready var raycastDamage = $RaycastsDamage
@onready var rayDmgRight = $RaycastsDamage/RayCast2DRight
@onready var rayDmgLeft = $RaycastsDamage/RayCast2DLeft
@onready var rayDmgDown = $RaycastsDamage/RayCast2Down
@onready var rayDmgUp = $RaycastsDamage/RayCast2DUp

var direccionX = 0
var direccionY = 0



func _ready():
	animation_player.play("dormido")
	
func _process(delta):
	for ray in raycastDamage.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			player = colision
			estadoActual = estados.WAKEUP
			break
	if estadoActual == estados.WAKEUP and player != null:
		animation_player.play("wakeUp")
		await animation_player.animation_finished
		if rayDmgRight.is_colliding():
			direccionX = 1
		elif rayDmgLeft.is_colliding():
			direccionX = -1
		elif rayDmgDown.is_colliding():
			direccionY = 1
		elif rayDmgUp.is_colliding():
			direccionY = -1 
			
		player = null
	velocity.x = direccionX *200
	velocity.y = direccionY *200
	move_and_slide()


func _on_dmg_player_he_hecho_danio():
	$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
	for ray in raycastDamage.get_children():
		ray.enabled = false
