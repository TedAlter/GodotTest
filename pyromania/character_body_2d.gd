extends CharacterBody2D


const SPEEDTF = 200.0
const SPEEDLR = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2DTC
@onready var mv = "S"
@onready var dir = "t"

@onready var ip = false
@onready var cont = true



func _physics_process(delta):
	if ip:
		$CollisionShape2D.disabled=true
		$CollisionShapePlatformer.disabled=false
	else:
		$CollisionShape2D.disabled=false
		$CollisionShapePlatformer.disabled=true
		
	if ip and cont:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY*$".".scale.y
	
	
	var directionTF = Input.get_axis("move_up","move_down")
	if not ip and cont:
		if directionTF:
			velocity.y = directionTF * SPEEDTF*$".".scale.y
		else:
			velocity.y = move_toward(velocity.y, 0, SPEEDTF)

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR = Input.get_axis("move_left","move_right")
	if cont:
		if directionLR:
			velocity.x = directionLR * SPEEDLR*$".".scale.x
		else:
			velocity.x = move_toward(velocity.x, 0, SPEEDLR)
	
	move_and_slide()
	if velocity.x!=0 or velocity.y!=0:
		mv="W"
	else:
		mv="S"
	if cont:
		if velocity.y < 0 and velocity.x ==0 and not ip:
			dir = "f"	
		elif velocity.y > 0 and velocity.x ==0 and not ip:
			dir = "t"
		elif velocity.x >0:
			dir = "r"
		elif velocity.x <0:
			dir = "l"
		
	
	anim.play(mv+dir)
	
