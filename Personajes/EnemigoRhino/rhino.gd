extends CharacterBody2D
class_name Rhino
@onready var anim = $AnimationPlayer
@onready var ray_casts = $RayCasts
@onready var ray_cast_2d_player_2_right = $RayCasts/RayCast2DPlayer2Right
@onready var ray_cast_2d_player_left = $RayCasts/RayCast2DPlayerLeft


@onready var ray_cast_2d_wall = $RayCast2DWall



var direction = -1
enum states {ANGRY,IDLE,DIE,WALKING}
var player
var canChangeDirection = true
var gravity = 9
var speed = 0
var life = 2


var actualState = states.IDLE :
	set(value):
		actualState = value
		match value:
			states.ANGRY:
				anim.play("runAngry")
				speed = 250
			states.IDLE:
				anim.play("idle")
				speed = 0
			states.WALKING:
				anim.play("runAngry")
				speed = 60
				
func _ready():
	anim.play("idle")

func _physics_process(delta):
	velocity.x = direction * speed
	if !is_on_floor(): #if enemy is not on the floor, apply gravity
		velocity.y += gravity
	move_and_slide()
	
func _process(delta):
	for ray in ray_casts.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				player = colision
				actualState = states.ANGRY #if detect a player, change state to angry
				
			
	if ray_cast_2d_wall.is_colliding() and canChangeDirection:
		anim.play("hitWall") #if collision with a wall, make animation of hitwall
		await anim.animation_finished
		turnAround() #after the animation hitwall, he change direction
	if $RayCasts/RayCast2DPlayer2Right.is_colliding() and direction == -1:
		turnAround()
	elif $RayCasts/RayCast2DPlayerLeft.is_colliding() and direction == 1:
		turnAround()
		
	$Sprite2D.flip_h = true if direction == 1 else false


func turnAround():
	canChangeDirection = false
	ray_cast_2d_wall.scale.x *=-1
	direction *= -1
	$dmgPlayer/CollisionShape2D.position.x *= -1
	$CollisionShape2D.position.x *= -1
	player = null
	$Timer2.start()
	$Sprite2D.flip_h = true if direction == 1 else false
	actualState = states.WALKING
	$RayCasts/RayCast2DPlayer2Right.enabled = false
	$RayCasts/RayCast2DPlayerLeft.enabled = false
	$Timer.start()
	

func takeDmg(damage): #function called when a player hit the enemy
	player = null
	life -= damage
	if life <= 0:
		$dmgPlayer/CollisionShape2D.set_deferred("disabled",true)
		actualState = states.DIE
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		morir()
	else:
		speed = 0
		gravity = 0
		$CollisionShape2D.set_deferred("disabled",true)
		anim.play("hurt")
		await (anim.animation_finished)
		$CollisionShape2D.set_deferred("disabled",false)
		gravity = 9
		actualState = states.IDLE



func _on_timer_timeout():
	canChangeDirection = true


func _on_timer_2_timeout():
	actualState = states.IDLE
	$RayCasts/RayCast2DPlayer2Right.enabled = true
	$RayCasts/RayCast2DPlayerLeft.enabled = true
func morir():
	queue_free()


func _on_dmg_player_i_made_damage(): #if colision with a player and make damage, state walking
	$Timer2.start()
	actualState = states.WALKING
	$RayCasts/RayCast2DPlayer2Right.enabled = false
	$RayCasts/RayCast2DPlayerLeft.enabled = false
