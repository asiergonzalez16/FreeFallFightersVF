extends CharacterBody2D
class_name Rhino
@onready var anim = $AnimationPlayer
@onready var ray_casts = $RayCasts
@onready var ray_cast_2d_player_2_right = $RayCasts/RayCast2DPlayer2Right
@onready var ray_cast_2d_player_left = $RayCasts/RayCast2DPlayerLeft


@onready var ray_cast_2d_wall = $RayCast2DWall



var direccion = -1
enum estados {ANGRY,IDLE,MORIRSE,WALKING}
var player
var canChangeDirection = true
var gravity = 9
var speed = 0
var vida = 2


var estadoActual = estados.IDLE :
	set(value):
		estadoActual = value
		match value:
			estados.ANGRY:
				anim.play("runAngry")
				speed = 250
			estados.IDLE:
				anim.play("idle")
				speed = 0
			
				
func _ready():
	anim.play("idle")

func _physics_process(delta):
	velocity.x = direccion * speed
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()
	
func _process(delta):
	for ray in ray_casts.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				player = colision
				estadoActual = estados.ANGRY
				
			
	if ray_cast_2d_wall.is_colliding() and canChangeDirection:
		anim.play("hitWall")
		await anim.animation_finished
		darseVuelta()
		
	$Sprite2D.flip_h = true if direccion == 1 else false



func darseVuelta():
	canChangeDirection = false
	ray_cast_2d_wall.scale.x *=-1
	direccion *= -1
	$dmgPlayer/CollisionShape2D.position.x *= -1
	$CollisionShape2D.position.x *= -1
	estadoActual = estados.IDLE
	player = null
	$Timer.start()

func takeDmg(damage):
	player = null
	vida -= damage
	print (vida)
	if vida <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		estadoActual = estados.MORIRSE
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
	else:
		speed = 0
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurt")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		gravity = 9
		estadoActual = estados.WALKING
		



func _on_dmg_player_he_hecho_danio():
	darseVuelta()



func _on_timer_timeout():
	canChangeDirection = true
