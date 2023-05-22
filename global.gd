extends Node

var inicio = true
var bandera = true
var checkX = 0
var checkY = 0
var levels = []
var unlockLevels = 1
var ultimoBotonPressed = 0

var actualPointsLevel1 = 0
var actualPointsLevel2 = 0
var actualPointsLevel3 = 0

var topScoreLevel1 :int
var topScoreLevel2 :int
var topScoreLevel3 :int

var tiempo = 300


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
	
	topScoreLevel1 = Save.game_data.topScoreLevel1
	topScoreLevel2 = Save.game_data.topScoreLevel2
	topScoreLevel3 = Save.game_data.topScoreLevel3
