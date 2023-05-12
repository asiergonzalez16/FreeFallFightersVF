extends Area2D



func _on_area_entered(area):
	var parent = get_node_or_null("..")
	if parent != null:
		parent.queue_free()
