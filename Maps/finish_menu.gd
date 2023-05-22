@tool
extends Node

func _ready():
	$Timer.start()
	Global.vidas = 5
	Save.game_data.VidasJugador = 5
	Save.save_data()
	$AnimCerdito.play("cerdito")
	$AnimRhino.play("rhino")
	$AnimSnail.play("snail")
	$AnimationPlayer.play("pink")
	$AnimPiedra.play("piedra")
	$AnimPlanta.play("planta")
	$AnimTortuga.play("tortuga")


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Maps/main_menu.tscn")
