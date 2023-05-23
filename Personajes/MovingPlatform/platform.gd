@tool
extends Path2D

@export var platformSpeed : float = .2 #if we make @export, we can change this variable from the editor, don't need modify code
var isRight = true

func _process(delta):
	#if Engine.is_editor_hint(): # Run only in the editor
	#if not Engine.is_editor_hint(): # Run only in the game
	$PlatformCharacter.global_position = $PathFollow2D.global_position
	
	if isRight:
		$PathFollow2D.progress_ratio += platformSpeed * delta
	else:
		$PathFollow2D.progress_ratio -= platformSpeed * delta
		
	if $PathFollow2D.progress_ratio >= 0.95:
		isRight = false
	elif $PathFollow2D.progress_ratio <= .05:
		isRight = true
