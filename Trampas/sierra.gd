@tool
extends Node2D

var dmg = 2
@export var platformSpeed : float = .6
var isRight = true

@onready var sprite = $SierraVerdadera/Sprite2D
@onready var path = $Path2D/PathFollow2D
@onready var sierra = $SierraVerdadera


func _process(delta):
	sprite.rotate(deg_to_rad(400*delta))
	
	sierra.global_position = path.global_position
	
	if isRight:
		path.progress_ratio += platformSpeed * delta
	else:
		path.progress_ratio -= platformSpeed * delta
	
	if path.progress_ratio >= 0.95:
		isRight = false
	elif path.progress_ratio <= .05:
		isRight = true
