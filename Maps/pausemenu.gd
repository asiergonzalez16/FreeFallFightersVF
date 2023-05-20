extends CanvasLayer

@onready var pausemenu = $pausemenu


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pausemenu.visible = true
		get_tree().paused = true


func _on_resume_button_pressed():
	pausemenu.visible = false
	get_tree().paused = false
