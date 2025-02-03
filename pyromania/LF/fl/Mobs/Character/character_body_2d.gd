extends CharacterBody2D


const SPEEDTF = 80.0
const SPEEDLR = 100.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2DTC
@onready var mv = "S"
@onready var dir = "t"

@export var ip: bool = false
@onready var cont = true

var ampx =1 #scale amplyfier of layer x
var ampy =1 #scale amplyfier of layer y
var psx = 0 #motion of layer x
var psy = 0 #motion of layer y


var amx = 1 #ADDITIVE scale amplyfier of layer x
var amy = 1 #ADDITIVE scale amplyfier of layer y

var aplied_force_velocity_x = 0 
var aplied_force_velocity_y = 0

var asmx = 1
var asmy = 1

func _physics_process(delta):
	self.scale.x=1
	self.scale.y=1
	
	aplied_force_velocity_x = 0 
	aplied_force_velocity_y = 0
	#алгоритм обработки пересекающихся зон
	for area in $Area2D.get_overlapping_areas():
		if area.get_parent() is CharacterBody2D and area.get_parent().get_parent() == self.get_parent() and area.get_parent().mv =="W":
			resist = self.weight*3 - area.get_parent().strength
			if resist <= 0:
				aplied_force_velocity_x +=area.get_parent().velocity.x*self.get_parent().pushamp
				aplied_force_velocity_y +=area.get_parent().velocity.y*self.get_parent().pushamp
			else:
				aplied_force_velocity_x +=area.get_parent().velocity.x*(area.get_parent().strength/(self.weight*3))*self.get_parent().pushamp
				aplied_force_velocity_y +=area.get_parent().velocity.y*(area.get_parent().strength/(self.weight*3))*self.get_parent().pushamp
				
	if (aplied_force_velocity_x>velocity.x and aplied_force_velocity_x>0 and velocity.x>=0)or(aplied_force_velocity_x<velocity.x and aplied_force_velocity_x<0 and velocity.x<=0) :
		velocity.x = aplied_force_velocity_x
	if ((aplied_force_velocity_y>velocity.y and aplied_force_velocity_y>0 and velocity.y>=0)or(aplied_force_velocity_y<velocity.y and aplied_force_velocity_y<0 and velocity.y<=0)) and not ip:
		velocity.y = aplied_force_velocity_y
	
	
	if Input.is_action_just_pressed("jump") :
			print(aplied_force_velocity_x)
			print(aplied_force_velocity_y)
	
	if self.get_parent() is ParallaxLayer:
		#self.collision_mask = self.get_parent().layer
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
		$Area2D/CollisionShape2DA.disabled=true
		$CollisionShapePlatformer.disabled=false
		$Area2D/CollisionShapePlatformerA.disabled = false
	else:
		$CollisionShape2D.disabled=false
		$Area2D/CollisionShape2DA.disabled=false
		$CollisionShapePlatformer.disabled=true
		$Area2D/CollisionShapePlatformerA.disabled = true
		
	if ip and cont:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = (JUMP_VELOCITY*ampy*amy)+psy
	
	
	var directionTF = Input.get_axis("move_up","move_down")
	if not ip and cont:
		if directionTF:
			velocity.y = (directionTF * SPEEDTF*ampy*amy)+psy
		else:
			if not ((aplied_force_velocity_y>velocity.y and aplied_force_velocity_y>0 and velocity.y>=0)or(aplied_force_velocity_y<velocity.y and aplied_force_velocity_y<0 and velocity.y<=0)):
				velocity.y = move_toward(velocity.y, 0, SPEEDTF)

		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR = Input.get_axis("move_left","move_right")
	if cont:
		if directionLR:
			velocity.x = (directionLR * SPEEDLR*ampx*amx)+psx
		else:
			if not ((aplied_force_velocity_x>velocity.x and aplied_force_velocity_x>0 and velocity.x>=0)or(aplied_force_velocity_x<velocity.x and aplied_force_velocity_x<0 and velocity.x<=0)) :
				velocity.x = move_toward(velocity.x, 0, SPEEDLR)
	
	
	
	move_and_slide()
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
	
	

var resist = 0

func _on_area_2d_body_entered(body):
	pass
func _on_area_2d_body_exited(body):
	pass

func _on_area_2d_area_entered(area):
	pass

func _on_area_2d_area_exited(area):
	pass
	
