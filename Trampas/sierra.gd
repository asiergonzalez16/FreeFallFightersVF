@tool
extends Node2D

var dmg = 2
@export var platformSpeed : float = .6
var isRight = true

@onready var sprite = $SierraVerdadera/Sprite2D
@onready var path = $Path2D/PathFollow2D
@onready var sierra = $SierraVerdadera


func _process(delta):
	sprite.rotate(deg_to_rad(400*delta)) #rotate the velocity 400 º each second
	
	sierra.global_position = path.global_position
	
	if isRight:
		path.progress_ratio += platformSpeed * delta #advance the sierra to the path defined with the pathfollow2D
	else:
		path.progress_ratio -= platformSpeed * delta #advance the sierra to the path defined with the pathfollow2D
	
	if path.progress_ratio >= 0.95: #if the sierra is in the end of the path on the right, change direction
		isRight = false
	elif path.progress_ratio <= .05:
		isRight = true
