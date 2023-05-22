extends CharacterBody2D
class_name SpikeHead
var speed 
var firstTime = true
var restart = false
enum states {REPOSO,DESPIERTO,ACTIVO,INACTIVO}
var actualState = states.REPOSO:
	set(value):
		actualState = value
		match value:
			states.DESPIERTO:
				animation_player.play("despierto")
			states.INACTIVO:
				direccionX = 0 
				direccionY = 0

var player
@onready var animation_player = $AnimationPlayer
@onready var raycastDamage = $RaycastsDamage
@onready var rayDmgRight = $RaycastsDamage/RayCast2DRight
@onready var rayDmgLeft = $RaycastsDamage/RayCast2DLeft
@onready var rayDmgDown = $RaycastsDamage/RayCast2Down
@onready var rayDmgUp = $RaycastsDamage/RayCast2DUp




@onready var direccionX = 0
@onready var direccionY = 0
@onready var atacar = true



func _ready():
	animation_player.play("dormido")
	

	
func _process(delta):
	if rayDmgRight.is_colliding() and actualState != states.ACTIVO and direccionY == 0:
		if firstTime:
			actualState = states.DESPIERTO
		direccionX = 1
	elif rayDmgLeft.is_colliding() and actualState != states.ACTIVO and direccionY == 0:
		if firstTime:
			actualState = states.DESPIERTO
		direccionX = -1
	elif rayDmgDown.is_colliding() and actualState != states.ACTIVO and direccionX == 0:
		if firstTime:
			actualState = states.DESPIERTO
		direccionY = 1
	elif rayDmgUp.is_colliding() and actualState != states.ACTIVO and direccionX == 0:
		if firstTime:
			actualState = states.DESPIERTO
		direccionY = -1 
	
	if actualState == states.DESPIERTO and firstTime:
		firstTime = false
		animation_player.play("wakeUp")
		$despierto.start()
	
	if actualState == states.ACTIVO  and atacar:
		atacar = false	
		velocity.x = direccionX *400
		velocity.y = direccionY *400
		restart = true
	if ($Node2D/RayWorldDown.is_colliding() or $Node2D/RayWorldUp.is_colliding() or $Node2D/RayWorldRight.is_colliding() or $Node2D/RayWorldLeft.is_colliding()) and restart == true:
		actualState = states.INACTIVO
		restart = false
		$volverAtacar.start()
	
	move_and_slide()





func _on_volver_atacar_timeout():
	atacar = true
	player = null
	actualState = states.ACTIVO


func _on_despierto_timeout():
	actualState = states.ACTIVO
	
