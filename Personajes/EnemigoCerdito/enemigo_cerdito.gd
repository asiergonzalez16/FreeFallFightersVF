extends Personajes

var direccion = -1:
	set(value):
		if value != direccion:
			darseVuelta()
		direccion = value
		

@onready var raySuelo : RayCast2D = $Raycasts/RayCastSuelo
@onready var rayMuro : RayCast2D = $Raycasts/RayCastMuro
@onready var rayos := $Raycasts
@onready var raycastPlayer = $RaycastPlayerDetector
@onready var anim = $AnimationPlayer

var gravity = 9

var player
var canChangeDirection = true


enum estados {ANGRY,PATRULLAR, MORIRSE}
var estadoActual = estados.PATRULLAR :
	set(value):
		estadoActual = value
		match value:
			estados.ANGRY:
				anim.play("runAngry")
				speed = 90
			estados.PATRULLAR:
				anim.play("walk")
				speed = 60

func _ready():
	anim.play("walk")
	speed = 60
	
func _physics_process(delta):
	velocity.x = direccion * speed
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()


func _process(delta):
	
	if player == null and raycastPlayer.is_colliding():
		var colision = raycastPlayer.get_collider()
		if colision.is_in_group("Player"):
			player = colision
			estadoActual = estados.ANGRY
			
	
	if estadoActual == estados.PATRULLAR:
		if canChangeDirection and (rayMuro.is_colliding() or !raySuelo.is_colliding()):
			direccion*=-1
			
	if estadoActual == estados.ANGRY and player != null:
		anim.play("runAngry")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif  directionPlayer.x > 0:
			direccion = 1
<<<<<<< Updated upstream
	
	if estadoActual == estados.PATRULLAR:
		if canChangeDirection and (rayMuro.is_colliding() or !raySuelo.is_colliding()):
			direccion*=-1
=======
		
>>>>>>> Stashed changes
	$Sprite2D.flip_h = true if direccion == 1 else false
	
func takeDmg(damage):
	player = null
	vida -= damage
	print(vida)
	if vida <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		estadoActual = estados.MORIRSE
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
		
	else:
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurt")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		gravity = 9
		estadoActual = estados.PATRULLAR

func _on_ray_timer_timeout():
	canChangeDirection = true

func darseVuelta():
	canChangeDirection = false
	$Raycasts/RayTimer.start()
	rayos.scale.x *= -1
	raycastPlayer.scale.x *=-1

func _on_dmg_player_he_hecho_danio():
	estadoActual = estados.PATRULLAR
	player = null
	direccion *=-1
