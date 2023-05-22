extends Personajes
var direction = -1:
	set(value):
		if value != direction:
			darseVuelta()
		direction = value
		

@onready var raySuelo : RayCast2D = $Raycasts/RayCastSuelo
@onready var rayMuro : RayCast2D = $Raycasts/RayCastMuro
@onready var rayos := $Raycasts
@onready var raycastPlayer = $RaycastPlayerDetector
@onready var anim = $AnimationPlayer

var player
var canChangeDirection = true
var gravity = 9

enum states {ANGRY,PATRULLAR, MORIRSE}
var actualState = states.PATRULLAR :
	set(value):
		actualState = value
		match value:
			states.ANGRY:
				anim.play("runAngry")
				speed = 90
			states.PATRULLAR:
				anim.play("walk")
				speed = 60

func _ready():
	anim.play("walk") #animacion de caminar
	speed = 60

func _physics_process(delta):
	velocity.x = direction * speed
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()


func _process(delta):
	if player == null and raycastPlayer.is_colliding():
		var colision = raycastPlayer.get_collider()
		if colision.is_in_group("Player"):
			player = colision
			actualState = states.ANGRY
	if actualState == states.ANGRY and player != null:
		anim.play("runAngry")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direction = -1
		elif  directionPlayer.x > 0:
			direction = 1
		
	if actualState == states.PATRULLAR:
		if canChangeDirection and (rayMuro.is_colliding() or !raySuelo.is_colliding()):
			direction*=-1
	$Sprite2D.flip_h = true if direction == 1 else false
	
	if rayMuro.is_colliding():
		darseVuelta()
	
func takeDmg(damage):
	player = null
	life -= damage
	if life <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		actualState = states.MORIRSE
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
		actualState = states.PATRULLAR

func _on_ray_timer_timeout():
	canChangeDirection = true

func darseVuelta():
	canChangeDirection = false
	$Raycasts/RayTimer.start()
	rayos.scale.x *= -1
	raycastPlayer.scale.x *=-1

func _on_dmg_player_he_hecho_danio():
	actualState = states.PATRULLAR
	player = null
	direction *=-1
	
func morir():
	queue_free()
