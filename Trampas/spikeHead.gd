extends CharacterBody2D
class_name SpikeHead
var speed 
var primeraVez = true
var reiniciar = false
enum estados {REPOSO,DESPIERTO,ACTIVO,INACTIVO}
var estadoActual = estados.REPOSO:
	set(value):
		estadoActual = value
		match value:
			estados.DESPIERTO:
				animation_player.play("despierto")
			estados.INACTIVO:
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
	print(estadoActual)
	
	if rayDmgRight.is_colliding() and estadoActual != estados.ACTIVO and direccionY == 0:
		if primeraVez:
			estadoActual = estados.DESPIERTO
		direccionX = 1
	elif rayDmgLeft.is_colliding() and estadoActual != estados.ACTIVO and direccionY == 0:
		if primeraVez:
			estadoActual = estados.DESPIERTO
		direccionX = -1
	elif rayDmgDown.is_colliding() and estadoActual != estados.ACTIVO and direccionX == 0:
		if primeraVez:
			estadoActual = estados.DESPIERTO
		direccionY = 1
	elif rayDmgUp.is_colliding() and estadoActual != estados.ACTIVO and direccionX == 0:
		if primeraVez:
			estadoActual = estados.DESPIERTO
		direccionY = -1 
	
	if estadoActual == estados.DESPIERTO and primeraVez:
		primeraVez = false
		animation_player.play("wakeUp")
		$despierto.start()
	
	if estadoActual == estados.ACTIVO  and atacar:
		atacar = false	
		velocity.x = direccionX *400
		velocity.y = direccionY *400
		reiniciar = true
	if ($Node2D/RayWorldDown.is_colliding() or $Node2D/RayWorldUp.is_colliding() or $Node2D/RayWorldRight.is_colliding() or $Node2D/RayWorldLeft.is_colliding()) and reiniciar == true:
		estadoActual = estados.INACTIVO
		reiniciar = false
		$volverAtacar.start()
	
	move_and_slide()





func _on_volver_atacar_timeout():
	atacar = true
	player = null
	estadoActual = estados.ACTIVO


func _on_despierto_timeout():
	estadoActual = estados.ACTIVO
	








