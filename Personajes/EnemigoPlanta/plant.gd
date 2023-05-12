extends CharacterBody2D
class_name Planta
const BULLET_SCENE = preload("res://Personajes/EnemigoPlanta/plant_bullet.tscn")
@onready var anim = $AnimationPlayer
@onready var direccion = -1
var player
var estadoActual = estados.IDLE 
var vida = 1
@onready var canshoot = false
@onready var raycasts = $raycasts
@onready var bullet = null

enum estados {IDLE, DISPARAR}
func _ready():
	anim.play("idle")
func _process(delta):
	for ray in raycasts.get_children():
		if player == null and ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Player"):
				player = colision
				canshoot = true
				estadoActual = estados.DISPARAR
	if estadoActual == estados.DISPARAR and player != null and canshoot:
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif  directionPlayer.x > 0:
			direccion = 1
		$Sprite2D.flip_h = true if direccion == 1 else false
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
	bullet.global_position = self.global_position
	bullet.move_and_slide()
func takeDmg(damage):
	vida -= damage
	if vida <= 0:
		anim.play("hurt")
		$CollisionShape2D.set_deferred("disabled",true)
		await (anim.animation_finished)
		queue_free()
