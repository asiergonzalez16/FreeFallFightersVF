extends Area2D

@export var siguienteNivel: String




func _on_body_entered(body):
	if body is Player:
		Global.inicio = true
		body.transition_to_scene(siguienteNivel)
