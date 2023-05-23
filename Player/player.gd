extends CharacterBody2D
class_name Player


var speed := 120
var direction := 0
var jump := 250
const gravity := 9
var damage = 1
var canDash = true
var maxLives = 5
var counterUnlockedLevels = 0


#Declaration of nodes
@onready var rayDown = $RaysChoque/RayCastDown
@onready var rayUp = $RaysChoque/RayCastUP
@onready var rayRight = $RaysChoque/RayCastRight
@onready var rayLeft = $RaysChoque/RayCastLeft
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
var numJumps = 2

var vida := 5 : 
	set(val):
		vida = val
		$PlayerGUI/HPProgressBar.value = vida

func _ready():
	if !Global.start: #Checking if its the start, we use with the check point
		position.x = Global.checkX
		position.y = Global.checkY
		
	vidas_label.text = "x"+str(Save.game_data.VidasJugador) #Check on the script the lives you have
	gui_animation_player.play("TransitionAnim")
	$PlayerGUI/HPProgressBar.value = vida
	Global.connect("fruitCollected",actualizaInterfazFrutas)
	
func reiniciaSaltos():
	numJumps = 2
	
func _process(delta): #This runs all the time
	Global.time-= delta
	#We check in which map is the player for calculate the points
	if Global.lastButtonPressed == 1:
		$PlayerGUI/HBoxContainer2/Label.text = str(Global.actualPointsLevel1)
	elif Global.lastButtonPressed == 2:
		$PlayerGUI/HBoxContainer2/Label.text = str(Global.actualPointsLevel2)
	else:
		$PlayerGUI/HBoxContainer2/Label.text = str(Global.actualPointsLevel3)
	
	#If player recolect 10 fruits, you get 1 live and reset fruits to 0
	if Global.fruits >= 10:
		Global.fruits = 0
		Global.lives += 1
		Save.game_data.VidasJugador += 1
		Save.save_data()
		vidas_label.text = "x"+str(Save.game_data.VidasJugador)
	$LabelState.text = $StateMachine.state.name
	
	if is_on_floor() and numJumps != 2 and state_machine.state.name !="enAire":
		reiniciaSaltos()
	
	#We check the raycast of  the player, if is colliding we check if the colision is an enemy 
	#and have an expecific method then we call a method for make damage on the enemy
	for ray in raycastDmg.get_children():
		if ray.is_colliding():
			var colision = ray.get_collider()
			if colision.is_in_group("Enemigos") and colision.has_method("takeDmg"):
				if Global.lastButtonPressed == 1:
					Global.actualPointsLevel1 += 15
				elif Global.lastButtonPressed == 2:
					Global.actualPointsLevel2 += 15
				elif Global.lastButtonPressed == 3:
					Global.actualPointsLevel3 += 15
				colision.takeDmg(damage)
				state_machine.transition_to("enAire",{Salto = true})
				numJumps+=1
				break
	if is_on_floor() or is_on_wall():
		canDash = true

func actualizaInterfazFrutas():
	frutasLabel.text = str(Global.fruits)

func takeDamage(dmg):
	vida-=dmg
	state_machine.transition_to("takeDamage")
	if vida <= 0:
		morir()
		

func takeDamageRhino(dmg,side): #if rhino hits player, this method will execute
	vida-=dmg
	state_machine.transition_to("takeDamage",{Empuje = true, Lado = side})
	if vida <= 0:
		morir()
func takeDamageSpikeHead(dx,dy,sobrante):
	state_machine.transition_to("takeDamage",{Arrastrar = true, dx = dx, dy = dy,sobrante = sobrante})
	
#We call this method when player get no life on the lifebar, or fall down out of the map.
func morir():
	if Global.flag: #if flag is true, means we didn't take the checkpoint, to all points goes to 0
		if Global.lastButtonPressed == 1:
			Global.actualPointsLevel1 = 0
		elif Global.lastButtonPressed == 2:
			Global.actualPointsLevel2 = 0
		else:
			Global.actualPointsLevel3 = 0
	Global.lives -= 1
	Global.fruits = 0
	Global.flag = true
	Save.game_data.VidasJugador -= 1
	Save.save_data()
	
	if Save.game_data.VidasJugador <= 0: #If player has less or equals 0 lives, reset all and game over sreen transition
		Save.game_data.VidasJugador = maxLives
		Global.start = true
		Save.save_data()
		transition_to_scene("res://Maps/game_over.tscn")
	
	else: #if player have more than 0 lives, reload scene from the checkpoint or the start
		gui_animation_player.play_backwards("TransitionAnim")
		get_tree().paused = true
		await(gui_animation_player.animation_finished)
		get_tree().paused = false
		get_tree().reload_current_scene()

func transition_to_scene(scene : String): #Method for the animation transition
	gui_animation_player.play_backwards("TransitionAnim")
	get_tree().paused = true
	await(gui_animation_player.animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)



func _on_quit_button_pressed(): #button on pause menu to return menu, we restart all variables for default.
	Global.fruits = 0
	Global.time = 300
	Global.start = true
	Global.flag = true
	Global.actualPointsLevel1 = 0
	Global.actualPointsLevel2 = 0
	Global.actualPointsLevel3 = 0
	transition_to_scene("res://Maps/main_menu.tscn")
