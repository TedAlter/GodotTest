extends Area3D
@onready var timer:Timer = $Timer

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is RigidBody3D and body.name == "Player":
			var cloned_timer = timer.duplicate()  # Клонируем таймер
			cloned_timer.one_shot = true  # Устанавливаем, чтобы таймер не повторялся
			body.add_child(cloned_timer)  # Добавляем к объекту
		# Запускаем таймер
			cloned_timer.start()
			queue_free()

# Обработчик таймера уже не зависит от зоны
