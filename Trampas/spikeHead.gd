extends CharacterBody2D
class_name SpikeHead
var speed 
var firstTime = true
var restart = false
enum states {REPOSE,AWAKE,ACTIVE,INACTIVE}
var actualState = states.REPOSE:
	set(value):
		actualState = value
		match value:
			states.AWAKE:
				animation_player.play("despierto")
			states.INACTIVE:
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
	

	
func _process(delta): #lot of conditions for the movement of the spikeHead, directions
	if rayDmgRight.is_colliding() and actualState != states.ACTIVE and direccionY == 0:
		if firstTime: #if its the first time colision, change state to awake
			actualState = states.AWAKE
		direccionX = 1
	elif rayDmgLeft.is_colliding() and actualState != states.ACTIVE and direccionY == 0:
		if firstTime:
			actualState = states.AWAKE
		direccionX = -1
	elif rayDmgDown.is_colliding() and actualState != states.ACTIVE and direccionX == 0:
		if firstTime:
			actualState = states.AWAKE
		direccionY = 1
	elif rayDmgUp.is_colliding() and actualState != states.ACTIVE and direccionX == 0:
		if firstTime:
			actualState = states.AWAKE
		direccionY = -1 
	
	if actualState == states.AWAKE and firstTime: #if its the first time and state is awake, play animation wakeup
		firstTime = false
		animation_player.play("wakeUp")
		$despierto.start()
	
	if actualState == states.ACTIVE  and atacar: #if state is active and can attack, change velocity
		atacar = false	
		velocity.x = direccionX *400
		velocity.y = direccionY *400
		restart = true
	if ($Node2D/RayWorldDown.is_colliding() or $Node2D/RayWorldUp.is_colliding() or $Node2D/RayWorldRight.is_colliding() or $Node2D/RayWorldLeft.is_colliding()) and restart == true:
		actualState = states.INACTIVE
		restart = false
		$volverAtacar.start()
	
	move_and_slide()





func _on_volver_atacar_timeout(): #if timeout ends, he can attack again and return to state active
	atacar = true
	player = null
	actualState = states.ACTIVE


func _on_despierto_timeout(): #after despierto time ends, change to active state
	actualState = states.ACTIVE
	
