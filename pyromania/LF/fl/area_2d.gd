extends Area2D

@export var target_position: Vector2
@export var move_speed = 10  # Скорость перемещения


func moveto(fobj, pos: Vector2, speed: float) -> void:
	fobj.ip = false
	fobj.cont = false
	fobj.velocity.x = 0
	fobj.velocity.y = 0
	
	var direction = (pos - fobj.global_position).normalized()
	var movement = direction * speed

	# Пока персонаж не достиг цели
	while fobj.global_position.distance_to(pos) > movement.length():
		fobj.global_position += movement
		await get_tree().create_timer(0.01).timeout  # Ждем 0.01 секунды

	# Окончательное положение персонажа
	fobj.global_position = pos
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		await moveto(body,target_position,move_speed)
		body.ip = true
		body.cont = true
