extends CanvasLayer

@onready var full_screen_check_box = $Panel/VBoxContainer/FullScreenHBoxContainer2/FullScreenCheckBox
@onready var window_size_check_box = $Panel/VBoxContainer/WindowSizeHBoxContainer3/WindowSizeCheckBox
@onready var sfxh_slider = $Panel/VBoxContainer/SoundHBoxContainer/SFXHSlider
@onready var music_h_slider = $Panel/VBoxContainer/SoundHBoxContainer2/MusicHSlider
@onready var master_h_slider = $Panel/VBoxContainer/SoundHBoxContainer3/MasterHSlider


func _ready():
	hide()
	full_screen_check_box.button_pressed = Save.game_data.fullscreen_on
	_on_full_screen_check_box_pressed()
	sfxh_slider.value = Save.game_data.sfx_vol
	music_h_slider.value = Save.game_data.music_vol
	master_h_slider.value = Save.game_data.master_vol
	window_size_check_box.selected = Save.game_data.screen_res
	_on_window_size_check_box_item_selected(Save.game_data.screen_res)


func _on_confirm_button_pressed():
	hide()


func _on_full_screen_check_box_pressed():
	changeResolution()
	
func changeResolution():
	if full_screen_check_box.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		window_size_check_box.disabled = true
	else:
		window_size_check_box.disabled = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Save.game_data.fullscreen_on = full_screen_check_box.button_pressed
	Save.save_data()


func _on_window_size_check_box_item_selected(index): #window check box for select size of window
	var size : Vector2
	match index:
		0:
			size = Vector2(640,360)
		1:
			size = Vector2(1280,720)
		2:
			size = Vector2(1920,1080)
		3:
			size = Vector2(3840,2160)
	DisplayServer.window_set_size(size)
	Save.game_data.screen_res = index
	Save.save_data()




func _on_sfxh_slider_value_changed(value):
	update_vol(2,value)


func _on_music_h_slider_value_changed(value):
	update_vol(1,value)


func _on_master_h_slider_value_changed(value):
	update_vol(0,value)

func update_vol(index, vol):
	AudioServer.set_bus_volume_db(index,vol)
	match index:
		0:
			Save.game_data.master_vol = vol
		1:
			Save.game_data.sfx_vol = vol
		2:
			Save.game_data.music_vol = vol

	Save.save_data()
