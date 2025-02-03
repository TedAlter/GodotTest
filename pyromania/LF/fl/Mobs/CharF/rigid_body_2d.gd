extends RigidBody2D


@export var SPEEDTF:float = 80.0
@export var SPEEDLR:float = 100.0
@export var JUMP_VELOCITY:float= -400.0
@export var Force_x:float = 80.0
@export var Force_y:float = 80.0


@onready var anim = $AnimatedSprite2DTC
@onready var mv = "S"
@onready var dir = "t"

@export var ip: bool = false
@export var cont = true

var ampx =1 #scale amplyfier of layer x
var ampy =1 #scale amplyfier of layer y
var psx = 0 #motion of layer x
var psy = 0 #motion of layer y


var amx = 1 #ADDITIVE scale amplyfier of layer x
var amy = 1 #ADDITIVE scale amplyfier of layer y



func _physics_process(delta):
	
	self.scale.x=1
	self.scale.y=1
	if self.get_parent() is Parallax2D:
		self.collision_mask = self.get_parent().layer
		self.collision_layer= self.get_parent().layer
		ampx = self.get_parent().scale.x
		ampy = self.get_parent().scale.y
		psx = self.get_parent().parallax_speed.x
		psy = self.get_parent().parallax_speed.y
		amx = self.get_parent().amx
		amy = self.get_parent().amy
		
	else:
		ampx = 1
		ampy = 1
		psx =0
		psy =0
		self.collision_mask = 1
		amx = 1
		amy = 1
	if ip:
		$CollisionShape2D.disabled=true
		$CollisionShapePlatformer.disabled=false
	else:
		$CollisionShape2D.disabled=false
		$CollisionShapePlatformer.disabled=true
		
	if ip and cont:
		gravity_scale = 1
		if Input.is_action_just_pressed("jump") :
			pass
	if not ip and cont:
		gravity_scale = 0
	
	var directionTF = Input.get_axis("move_up","move_down")
	if not ip and cont:
		if directionTF:
			linear_velocity.y = directionTF * SPEEDTF*ampy*amy+psy
			apply_force(Vector2(0,Force_y))
		else:
			linear_velocity.y = 0+psy
			apply_force(Vector2(0,0))

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR = Input.get_axis("move_left","move_right")
	if cont:
		if directionLR:
			linear_velocity.x = directionLR * SPEEDLR#*ampx*amx+psx
			apply_force(Vector2(Force_x,0))
		else:
			linear_velocity.x = 0+psx
			apply_force(Vector2(0,0))
	
	

	if directionTF!=0 or directionLR!=0:
		mv="W"
	else:
		mv="S"
	if cont and mv=="W":
		if directionTF<0 and directionLR ==0 and not ip :
			dir = "f"	
		elif directionTF>0 and directionLR ==0 and not ip :
			dir = "t"
		elif directionLR >0 :
			dir = "r"
		elif directionLR <0:
			dir = "l"
	anim.play(mv+dir)
	
