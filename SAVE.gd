extends Node

const SAVEFILE = "user://SAVEFILE.save"
signal date_loaded
var game_data = { #Only work if the save file doesn't exist, this are the default values
	"VidasJugador" : 5,
	"MonedaExtra" : 0,
	#Settings
	"fullscreen_on" : false,
	"screen_res" : 1,
	"sfx_vol" : -10,
	"music_vol" : -10,
	"master_vol" : -10,
	#levels
	"levels_unlocked" : 1,
	#puntuación
	"topScoreLevel1" : 0,
	"topScoreLevel2" : 0,
	"topScoreLevel3" : 0
}

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ) #open for read
	if file == null: 
		save_data()
	else:
		var data_saved = file.get_var()
		
		for data in game_data.keys():
			if !game_data.keys().has(data):
				data_saved[data] = game_data[data]
		game_data = data_saved
		
	save_data()
	file = null

func save_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE) #open for write
	file.store_var(game_data)
	file = null


