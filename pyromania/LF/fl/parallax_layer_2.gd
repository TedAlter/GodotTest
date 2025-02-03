extends ParallaxLayer

var previous_position: Vector2
var parallax_speed: Vector2 = Vector2.ZERO
@export var layer:int = 2
@export var amx :float =2
@export var amy :float =2
@export var coh:float =0
@export var cov:float =0
@export var cm :float =1
@export var hnl :bool = false
func _ready():
	previous_position = global_position
func _process(delta: float) -> void:
	var current_position = global_position
	parallax_speed = (current_position - previous_position) / delta  # Вычисляем скорость
	previous_position = current_position  # Обновляем предыдущую позицию
	for child in self.get_children():
		if child.name=="Player" and hnl== true:
			 # Индекс текущего слоя
			for i in range(self.get_parent().get_child_count()):
				var bro = self.get_parent().get_child(i)
				if bro is ParallaxLayer and i > self.get_parent().get_children().find(self):  # Слои выше self скрыть
					bro.visible = false
			#for bro in self.get_parent().get_children():
				#if (bro is ParallaxLayer) and bro!= self:#тут нужно как-то доработать
					#bro.visible = false
		#else:
			#for bro in self.get_parent().get_children():
				#if bro is ParallaxLayer:
					#bro.visible = true
