extends Personajes
var direction = -1:
	set(value):
		if value != direction:
			turnAround()
		direction = value
		

@onready var raySuelo : RayCast2D = $Raycasts/RayCastSuelo
@onready var rayMuro : RayCast2D = $Raycasts/RayCastMuro
@onready var rayos := $Raycasts
@onready var raycastPlayer = $RaycastPlayerDetector
@onready var anim = $AnimationPlayer

var player
var canChangeDirection = true
var gravity = 9

enum states {ANGRY,PATROL, DIE}
var actualState = states.PATROL :
	set(value):
		actualState = value
		match value:
			states.ANGRY:
				anim.play("runAngry")
				speed = 90
			states.PATROL:
				anim.play("walk")
				speed = 60

func _ready():
	anim.play("walk") #animacion de caminar
	speed = 60

func _physics_process(delta):
	velocity.x = direction * speed
	if !is_on_floor(): #if enemy is not on the floor, we apply gravity
		velocity.y += gravity
	move_and_slide()


func _process(delta):
	if player == null and raycastPlayer.is_colliding():
		var colision = raycastPlayer.get_collider()
		if colision.is_in_group("Player"): #if the raycast detect a Player:
			player = colision
			actualState = states.ANGRY
	if actualState == states.ANGRY and player != null: #if state is ANGRY we change animation to runAngry
		anim.play("runAngry")
		var directionPlayer = global_position.direction_to(player.global_position) #the position of the enemy will follow the position of player
		if directionPlayer.x < 0:
			direction = -1
		elif  directionPlayer.x > 0:
			direction = 1
		
	if actualState == states.PATROL:
		if canChangeDirection and (rayMuro.is_colliding() or !raySuelo.is_colliding()): #is state is patrol and colision with wall or enemy, change direction
			direction*=-1
	$Sprite2D.flip_h = true if direction == 1 else false
	
	if rayMuro.is_colliding():
		turnAround()
	
func takeDmg(damage):
	player = null
	life -= damage
	if life <= 0: #if he has no more lives, make animation of die and remove from scene
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		actualState = states.DIE
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
	else: #if have more lives, make him animation of hurt and change state to Patrol
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurt")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		gravity = 9
		actualState = states.PATROL

func _on_ray_timer_timeout():
	canChangeDirection = true

func turnAround():
	canChangeDirection = false
	$Raycasts/RayTimer.start()
	rayos.scale.x *= -1
	raycastPlayer.scale.x *=-1

	
func morir(): #if dead, remove from scene
	queue_free()


func _on_dmg_player_i_made_damage(): #if he made damage, we change direction of the enemy and change state to Patrol
	actualState = states.PATROL
	player = null
	direction *=-1
