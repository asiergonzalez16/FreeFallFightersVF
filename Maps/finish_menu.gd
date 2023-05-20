extends Node

func _ready():
	Global.vidas = 5
	Save.game_data.VidasJugador = 5
	Save.save_data()
	$AnimCerdito.play("cerdito")
	$AnimRhino.play("rhino")
	$AnimSnail.play("snail")
	$AnimPiedra.play("piedra")
	$AnimPlanta.play("planta")
	$AnimTortuga.play("tortuga")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Maps/main_menu.tscn")
