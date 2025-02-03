extends Node3D


@export var cont = true


var direction="Srd"

@onready var StunTimer: Timer = $StanTimer

var mv = "S"
var dirTest: Vector2 = Vector2(0,0)
var dirplatformer:float=0
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _integrate_forces(state: PhysicsDirectBodyState) -> void:
func _physics_process(delta: float) -> void:
	if cont:
		if Input.get_axis("move_left","move_right")!=0 or Input.get_axis("move_up","move_down")!=0:
			mv="W"
			dirTest = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down"))
			dirplatformer = Input.get_axis("pl","pr")
		else:
			mv="S"
			dirTest = Vector2.ZERO
			dirplatformer = 0
		
func _process(delta):
	pass
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

		
	
