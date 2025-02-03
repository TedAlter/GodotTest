extends Camera2D

var character : CharacterBody2D  # Ссылка на персонажа.
var layer : ParallaxLayer  # Ссылка на слой, в котором находится персонаж.

var is_focused = false
# Параметры скорости.
var velocity_x : float = 0.0
var velocity_y : float = 0.0
var layer_scale : Vector2 = Vector2(1, 1)

func find_node_by_name_and_type(root_node, name) -> RigidBody2D:
	# Проходим по всем детям текущего узла
	for child in root_node.get_children():
		# Проверяем, соответствует ли имя и тип
		if child.name == name and child is RigidBody2D:
			return child
		# Рекурсивно ищем среди дочерних узлов
		var found = find_node_by_name_and_type(child, name)
		if found:
			return found
	return null  # Если ничего не найдено
	
var py = 1
var px = 1

func _ready():
	pass

func _process(delta):
	
	var character = find_node_by_name_and_type(get_tree().root, "PlayerF")
	if not is_focused:
		self.global_position = character.global_position
		is_focused = true
	if character.get_parent() is ParallaxLayer:
		layer = character.get_parent()
		layer_scale = layer.scale
		py = pow(layer_scale.y,-1)
		px = pow(layer_scale.x,-1)
		self.drag_horizontal_offset = layer.coh
		self.drag_vertical_offset = layer.cov
		self.zoom = Vector2(layer.cm,layer.cm)
	else:
		self.drag_horizontal_offset =0
		self.drag_vertical_offset = 0
		self.zoom = Vector2(1,1)
		is_focused = false
		px=1
		py=1
			
	velocity_x = character.linear_velocity.x
	velocity_y = character.linear_velocity.y
	

	# Камера двигается с вдвое большей скоростью, чем персонаж.
	var camera_velocity_x = velocity_x * px
	var camera_velocity_y = velocity_y * py

	# Передвигаем камеру по осям с учётом вычисленной скорости.
	self.position.x += (camera_velocity_x * delta)
	self.position.y += (camera_velocity_y * delta)
