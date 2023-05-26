extends CharacterBody2D
class_name Planta
const BULLET_SCENE = preload("res://Personajes/EnemigoPlanta/plant_bullet.tscn")
@onready var anim = $AnimationPlayer
@onready var direction = -1
var player
var actualState = states.IDLE 
var life = 1
@onready var canshoot = false
@onready var raycasts = $raycasts
@onready var bullet = null

enum states {IDLE, SHOOT}
func _ready():
	anim.play("idle")
	

func _process(delta):
	for ray in raycasts.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				player = colision
				canshoot = true
				actualState = states.SHOOT #if detect a player, he will change state to SHOOT
				
	if actualState == states.SHOOT and player != null and canshoot: #if can shoot and state is shoot:
		var directionPlayer = global_position.direction_to(player.global_position) #check the direction where is player and move to this direction
		if directionPlayer.x < 0:
			direction = -1
		elif  directionPlayer.x > 0:
			direction = 1
		$Sprite2D.flip_h = true if direction == 1 else false
		anim.play("shoot") #play the animation for shoot
		if $Sprite2D.flip_h == true:
			$CollisionShape2D.position.x *= -1
		anim.play("shoot")
		bullet = BULLET_SCENE.instantiate() #instantiate the scene for the bullet (in this animation will call method disparar()
		await anim.animation_finished
		anim.play("idle")
		canshoot = false
		$Timer.start() #start the time where he can't shoot
	
		


func _on_timer_timeout(): #after timeout, the enemy can shoot again
	canshoot= true
	player = null
	
func disparar(): #method for create a bullet and the position
	add_child(bullet)
	if direction == -1:
		bullet.global_position.x = self.global_position.x-20
		bullet.global_position.y = self.global_position.y-4
	else:
		bullet.global_position.x = self.global_position.x+20
		bullet.global_position.y = self.global_position.y-4
		
	bullet.move_and_slide()
	
func takeDmg(damage): #func called when player jump over the enemy and hit
	life -= damage
	if life <= 0: #if lives less or equals than 0, die
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
