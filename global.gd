extends Node

var inicio = true
var bandera = true
var checkX = 0
var checkY = 0
var levels = []
var unlockLevels = 1

signal fruitCollected
var frutas := 0 :
	set(val):
		frutas = val
		emit_signal("fruitCollected")
		$frutasSonido.play()
	get:
		return frutas

var vidas : int



func _ready():
	await Save.ready
	vidas = Save.game_data.VidasJugador
