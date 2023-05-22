extends Area2D

signal heHechoDanio


@export var danio = 1
@export var side = 0
@export var dx = 0
@export var dy = 0
@export var sobrante = 0

func _on_area_entered(area):
	var parent = get_node_or_null("..")
	if parent is Rhino and area.is_in_group("AreaPlayer"):
		if area.owner.global_position.x < global_position.x:
			side = -1
		else:
			side = 1
		area.owner.takeDamageRhino(danio,side)
		emit_signal("heHechoDanio")
	elif parent is SpikeHead and area.is_in_group("AreaPlayer"):
		if area.owner.global_position.x > global_position.x and parent.direccionX != 0 and parent.estadoActual == parent.estados.INACTIVO:
			dx = 1
			sobrante = (($CollisionShape2D.shape.extents.x) + (area.owner.dmgColision.shape.extents.x)) - abs(area.owner.global_position.x - global_position.x)
			area.owner.takeDamageSpikeHead(dx,dy,sobrante)
		elif area.owner.global_position.x < global_position.x and parent.direccionX != 0 and parent.estadoActual == parent.estados.INACTIVO:
			dx = -1
			sobrante = (($CollisionShape2D.shape.extents.x) + (area.owner.dmgColision.shape.extents.x)) - abs(area.owner.global_position.x - global_position.x)
			area.owner.takeDamageSpikeHead(dx,dy,sobrante)
		elif area.owner.global_position.y < global_position.y and parent.direccionY != 0 and parent.estadoActual == parent.estados.INACTIVO:
			dy = -1
			area.owner.takeDamageSpikeHead(dx,dy,sobrante)
		elif area.owner.global_position.y > global_position.y+30 and parent.direccionY != 0 and parent.estadoActual == parent.estados.INACTIVO:
			dy = 1
			area.owner.takeDamageSpikeHead(dx,dy,sobrante)
		else: 
			area.owner.takeDamage(danio)
	elif area.is_in_group("AreaPlayer"):
		area.owner.takeDamage(danio)
		emit_signal("heHechoDanio")


