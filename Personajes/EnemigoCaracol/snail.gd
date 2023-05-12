extends CharacterBody2D

var canChangeDirection = true
var gravity = 9
var speed = 0
var vida = 2
const snailWithoutShell = preload("res://Personajes/EnemigoCaracol/snailwithoutshell.tscn")

var direccion = -1:
	set(value):
		if value != direccion:
			darseVuelta()
		direccion = value

@onready var raySuelo : RayCast2D = $Raycasts/RayCastSuelo
@onready var rayMuro : RayCast2D = $Raycasts/RayCastMuro
@onready var rayos := $Raycasts
@onready var anim = $AnimationPlayer
@onready var spritecaracolsin = $Area2D/Sprite2D
@onready var babosa = null



enum estados {PATRULLAR, CAPARAZON}
var estadoActual = estados.PATRULLAR :
	set(value):
		estadoActual = value
		match value:
			estados.PATRULLAR:
				speed = 40
				anim.play("walk")
			estados.CAPARAZON:
				speed = 450
				anim.play("shell")


func _ready():
	snailWithoutShell.instantiate()
	anim.play("walk")
	speed = 40
	
func _physics_process(delta):
	velocity.x = direccion * speed
	if !is_on_floor():
		velocity.y += gravity
	move_and_slide()

func _process(delta):
	if(estadoActual == estados.CAPARAZON and rayMuro.is_colliding()):
		anim.play("hurtShell")

	if canChangeDirection and (rayMuro.is_colliding() or !raySuelo.is_colliding()):
			direccion*=-1
	$Sprite2D.flip_h = true if direccion == 1 else false
	
	if estadoActual == estados.CAPARAZON:
		speed -= 0.5
		if speed <= 0:
			speed = 0
			$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
			
	
	
func darseVuelta():
	canChangeDirection = false
	$Raycasts/RayTimer.start()
	rayos.scale.x *= -1

func _on_ray_timer_timeout():
	canChangeDirection = true
	
func takeDmg(damage):
	vida -= damage
	
	if vida <= 0:
		speed = 0
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurtShell")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
	else:
		babosa = snailWithoutShell.instantiate()
		add_child(babosa)
		babosa.global_position = self.global_position
		babosa.position.x = 0
		babosa.move_and_slide()
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurtShell")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		estadoActual = estados.CAPARAZON
		gravity = 9

func _on_dmg_player_he_hecho_danio():
	if estadoActual == estados.CAPARAZON:
		anim.play("hurtShell")
	rayMuro.scale.x *=-1
	direccion *=-1
	darseVuelta()
