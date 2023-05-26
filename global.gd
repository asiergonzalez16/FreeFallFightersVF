extends Node

#All variables declared here, can be used everywhere in the project

var start = true
var flag = true
var checkX = 0
var checkY = 0
var levels = []
var unlockLevels = 1
var lastButtonPressed = 0

var actualPointsLevel1 = 0
var actualPointsLevel2 = 0
var actualPointsLevel3 = 0
var continuePointing = true

var topScoreLevel1 :int
var topScoreLevel2 :int
var topScoreLevel3 :int

var time = 300


signal fruitCollected
var fruits := 0 :
	set(val):
		fruits = val
		emit_signal("fruitCollected")
		$frutasSonido.play()
	get:
		return fruits

var lives : int



func _ready():
	await Save.ready
	lives = Save.game_data.VidasJugador
	
	topScoreLevel1 = Save.game_data.topScoreLevel1
	topScoreLevel2 = Save.game_data.topScoreLevel2
	topScoreLevel3 = Save.game_data.topScoreLevel3
