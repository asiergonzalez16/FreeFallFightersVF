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

enum states {IDLE, DISPARAR}
func _ready():
	anim.play("idle")
func _process(delta):
	for ray in raycasts.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				player = colision
				canshoot = true
				actualState = states.DISPARAR
	if actualState == states.DISPARAR and player != null and canshoot:
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direction = -1
		elif  directionPlayer.x > 0:
			direction = 1
		$Sprite2D.flip_h = true if direction == 1 else false
		anim.play("shoot")
		if $Sprite2D.flip_h == true:
			$CollisionShape2D.position.x *= -1
		anim.play("shoot")
		bullet = BULLET_SCENE.instantiate()
		await anim.animation_finished
		anim.play("idle")
		canshoot = false
		$Timer.start()
	
		


func _on_timer_timeout():
	canshoot= true
	player = null
	
func disparar():
	add_child(bullet)
	if direction == -1:
		bullet.global_position.x = self.global_position.x-20
		bullet.global_position.y = self.global_position.y-4
	else:
		bullet.global_position.x = self.global_position.x+20
		bullet.global_position.y = self.global_position.y-4
		
	bullet.move_and_slide()
func takeDmg(damage):
	life -= damage
	if life <= 0:
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
