extends CharacterBody2D
class_name Player


var speed := 120
var direccion := 0.0
var jump := 250
const gravity := 9
var damage = 1

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutasLabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RaycastDmg
@onready var state_machine := $StateMachine
@onready var dmgColision := $CollisionShape2D

#enum estados {NORMAL, HERIDO}
#var estadoActual = estados.NORMAL
var numSaltos = 2

var vida := 10 : 
	set(val):
		vida = val
		$PlayerGUI/HPProgressBar.value = vida

func _ready():
	$PlayerGUI/HPProgressBar.value = vida
	Global.player = self
	
func reiniciaSaltos():
	numSaltos = 2
	
func _process(delta):
	$LabelState.text = $StateMachine.state.name
	if is_on_floor() and numSaltos != 2 and state_machine.state.name !="enAire":
		reiniciaSaltos()
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Enemigos") and colision.has_method("takeDmg"):
				colision.takeDmg(damage)
				state_machine.transition_to("enAire",{Salto = true})
				numSaltos+=1

#func _physics_process(delta):
#	if estadoActual == estados.NORMAL:
#		procesarNormal(delta)
#
#func procesarNormal(delta):
#	direccion = Input.get_axis("ui_left","ui_right")
#	velocity.x = direccion * speed
#	
#	if direccion != 0:
#		anim.play("walk")
#	else:
#		anim.play("idle")
#	
#	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
#	
#	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
#		$AudioSalto.play()
#		velocity.y -= jump
#	
#	if !is_on_floor():
#		velocity.y += gravity
#	move_and_slide()



func actualizaInterfazFrutas():
	frutasLabel.text = str(Global.frutas)

func takeDamage(dmg):
	vida-=dmg
	state_machine.transition_to("takeDamage")
	if vida <= 0:
		morir()
	
func morir():
	get_tree().reload_current_scene()
