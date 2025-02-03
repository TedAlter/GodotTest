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
	var fl = get_front_layer()
	# Аннулируем позицию переднего слоя
	fl.position = Vector2.ZERO
	for child in get_children():
		if child is ParallaxLayer:
			child.motion_scale = child.motion_mirroring/fl.motion_mirroring
			child.motion_mirroring = Vector2.ZERO
		
	
	
	
	
	
