extends Camera2D

# Имя объекта, который нужно отслеживать
@export var target_name: String = "Player"

# Объект, который будет отслеживаться
var target: Node2D = null

func _ready():
	# Ищем объект с заданным именем по всему древу сцены
	var root = get_tree().root
	target = find_object_by_name(root, target_name)
	if not target:
		print("Объект с именем '%s' не найден!" % target_name)

func _process(delta):
	# Если цель найдена, обновляем позицию камеры
	if target:
		global_position = target.global_position

# Рекурсивная функция для поиска объекта по имени
func find_object_by_name(node: Node, target_name: String) -> Node2D:
	if node.name == target_name:
		return node
	
	for child in node.get_children():
		var found = find_object_by_name(child, target_name)
		if found:
			return found
	
	return null
