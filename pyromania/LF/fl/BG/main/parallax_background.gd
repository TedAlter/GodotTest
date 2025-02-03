extends ParallaxBackground
func get_front_layer() -> ParallaxLayer:
	var front_layer = null
	var max_index = -1
	# Перебираем детей (слои) `ParallaxBackground`
	for child in get_children():
		if child is ParallaxLayer:
			var index = get_children().find(child)
			if index > max_index:
				max_index = index
				front_layer = child
	return front_layer
	
func _on_ready():
	for child in get_children():
		if child is ParallaxLayer:
			child.motion_scale = child.motion_mirroring / get_front_layer().motion_mirroring
	
