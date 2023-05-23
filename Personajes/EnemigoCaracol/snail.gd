extends CharacterBody2D

var canChangeDirection = true
var gravity = 9
var speed = 0
var life = 2
const snailWithoutShell = preload("res://Personajes/EnemigoCaracol/snailwithoutshell.tscn")

var direction = -1:
	set(value):
		if value != direction:
			turnAround()
		direction = value


@onready var raysuelo = $rayos/raysuelo
@onready var raymuro = $rayos/raymuro
@onready var rayos = $rayos
@onready var anim = $AnimationPlayer
@onready var slug = null



enum states {PATROL, SHELL}
var actualState = states.PATROL :
	set(value):
		actualState = value
		match value:
			states.PATROL:
				speed = 40
				anim.play("walk")
			states.SHELL:
				speed = 450
				anim.play("shell")


func _ready():
	anim.play("walk")
	speed = 40

func _physics_process(delta):
	velocity.x = direction * speed
	if !is_on_floor(): #if is not on the floor, we aply gravity
		velocity.y += gravity
	move_and_slide()

func _process(delta):
	if(actualState == states.SHELL and raymuro.is_colliding()): #making a animation when the snail in shell colision with wall
		anim.play("hurtShell")

	if canChangeDirection and (raymuro.is_colliding() or !raysuelo.is_colliding()): #change direction when colisioning
			direction*=-1
	$Sprite2D.flip_h = true if direction == 1 else false

	if actualState == states.SHELL: #when he change to shell, he get so much speed, but this speed with be stoping with the time
		speed -= 0.5
		if speed <= 0:
			speed = 0
			$dmgPlayer/CollisionShape2D.set_deferred("disabled",true) #if speed is 0, disable colision, will not make damage to the player



func turnAround():
	canChangeDirection = false
	$rayos/RayTimer.start()
	rayos.scale.x *= -1

func _on_ray_timer_timeout():
	canChangeDirection = true

func takeDmg(damage):
	life -= damage

	if life <= 0: 
		speed = 0
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurtShell")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished) #simuling he falling down
		queue_free() #after animation finished, we remove it from scene.
		
	else:
		#if still have life, it means he was hitted first time
		#We simule that the slug fall down and only is the shell
		snailWithoutShell.instantiate()
		slug = snailWithoutShell.instantiate()
		add_child(slug)
		slug.global_position = self.global_position
		slug.position.x = 0
		slug.move_and_slide()
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurtShell")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		actualState = states.SHELL
		gravity = 9


	


func _on_dmg_player_i_made_damage(): #if snail makes damage to player, play anim hurt and change direction
	if actualState == states.SHELL:
		anim.play("hurtShell")
	raymuro.scale.x *=-1
	direction *=-1
	turnAround()
