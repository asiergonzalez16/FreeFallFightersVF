extends CanvasLayer

@onready var pausemenu = $pausemenu


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("pause"): #if player press key "ESC" make visible the pausemenu and pause the game
		pausemenu.visible = true
		get_tree().paused = true


func _on_resume_button_pressed(): #resume button, stop pausing the game and make not visible the pausemenu
	pausemenu.visible = false
	get_tree().paused = false
