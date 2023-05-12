extends Area2D

signal heHechoDanio


@export var danio = 1
@export var side = 0

func _on_area_entered(area):
	var parent = get_node_or_null("..")
	if parent is Rhino and area.is_in_group("AreaPlayer"):
		if area.owner.global_position.x < global_position.x:
			side = -1
		else:
			side = 1
		area.owner.takeDamageRhino(danio,side)
		emit_signal("heHechoDanio")
	elif area.is_in_group("AreaPlayer"):
		area.owner.takeDamage(danio)
		emit_signal("heHechoDanio")


