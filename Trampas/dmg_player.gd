extends Area2D

signal IMadeDamage


@export var damage = 1
@export var side = 0
@export var dx = 0
@export var dy = 0
@export var leftovers = 0

func _on_area_entered(area):
	var parent = get_node_or_null("..")
	if parent is Rhino and area.is_in_group("AreaPlayer"): #if damage recieved is from Rhino
		if area.owner.global_position.x < global_position.x:
			side = -1
		else:
			side = 1
		area.owner.takeDamageRhino(damage,side) #call the method takeDamageRhino in the Player script
		emit_signal("IMadeDamage")
	elif parent is SpikeHead and area.is_in_group("AreaPlayer"): #If is not rhino, check if is SpikeHead
		if area.owner.global_position.x > global_position.x and parent.direccionX != 0 and parent.actualState == parent.states.INACTIVO:
			dx = 1
			leftovers = (($CollisionShape2D.shape.extents.x) + (area.owner.dmgColision.shape.extents.x)) - abs(area.owner.global_position.x - global_position.x)
			area.owner.takeDamageSpikeHead(dx,dy,leftovers)
		elif area.owner.global_position.x < global_position.x and parent.direccionX != 0 and parent.actualState == parent.states.INACTIVO:
			dx = -1
			leftovers = (($CollisionShape2D.shape.extents.x) + (area.owner.dmgColision.shape.extents.x)) - abs(area.owner.global_position.x - global_position.x)
			area.owner.takeDamageSpikeHead(dx,dy,leftovers)
		elif area.owner.global_position.y < global_position.y and parent.direccionY != 0 and parent.actualState == parent.states.INACTIVO:
			dy = -1
			area.owner.takeDamageSpikeHead(dx,dy,leftovers)
		elif area.owner.global_position.y > global_position.y+30 and parent.direccionY != 0 and parent.actualState == parent.states.INACTIVO:
			dy = 1
			area.owner.takeDamageSpikeHead(dx,dy,leftovers)
		else: 
			area.owner.takeDamage(damage)
	elif area.is_in_group("AreaPlayer"):
		area.owner.takeDamage(damage)
		emit_signal("IMadeDamage")


