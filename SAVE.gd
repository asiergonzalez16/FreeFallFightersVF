extends Node

const SAVEFILE = "user://SAVEFILE.save"
signal date_loaded
var game_data = { #Solo funciona cuando no existe el archivo de guardado
	"VidasJugador" : 5,
	"MonedaExtra" : 0,
	#Settings
	"fullscreen_on" : true,
	"screen_res" : 1,
	"sfx_vol" : -10,
	"music_vol" : -10,
	"master_vol" : -10
}

func _ready():
	load_data()
#	print(game_data)

func load_data():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	print(file)
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
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	file.store_var(game_data)
	file = null
