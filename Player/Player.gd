extends CharacterBody2D
class_name Player


var speed := 120
var direccion := 0.0
var jump := 250
const gravity := 9
var damage = 1
var canDash = true
var vidasMaximas = 5

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutasLabel := $PlayerGUI/HBoxContainer/FrutasLabel
@onready var raycastDmg := $RaycastDmg
@onready var state_machine := $StateMachine
@onready var dmgColision := $RecibirDanio/CollisionShape2D
@onready var gui_animation_player = $PlayerGUI/GUIAnimationPlayer
@onready var vidas_label = $PlayerGUI/VidasHBoxContainer/VidasLabel



#enum estados {NORMAL, HERIDO}
#var estadoActual = estados.NORMAL
var numSaltos = 2

var vida := 1 : 
	set(val):
		vida = val
		$PlayerGUI/HPProgressBar.value = vida

func _ready():
	vidas_label.text = "x"+str(Save.game_data.VidasJugador)
	gui_animation_player.play("TransitionAnim")
	$PlayerGUI/HPProgressBar.value = vida
	Global.connect("fruitCollected",actualizaInterfazFrutas)
	
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
				break
	if is_on_floor() or is_on_wall():
		canDash = true
	
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
	
	Global.vidas -= 1
	Save.game_data.VidasJugador -= 1
	Save.save_data()
	
	if Save.game_data.VidasJugador <= 0:
		Save.game_data.VidasJugador = vidasMaximas
		Save.save_data()
		transition_to_scene("res://Maps/main_menu.tscn")
	
	else:
		gui_animation_player.play_backwards("TransitionAnim")
		get_tree().paused = true
		await(gui_animation_player.animation_finished)
		get_tree().paused = false
		get_tree().reload_current_scene()

func transition_to_scene(scene : String):
	gui_animation_player.play_backwards("TransitionAnim")
	get_tree().paused = true
	await(gui_animation_player.animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)




func _on_quit_button_pressed(): #boton para volver al menu principal
	Global.frutas = 0
	transition_to_scene("res://Maps/main_menu.tscn")
