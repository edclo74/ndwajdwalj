extends CharacterBody2D
var is_ready: bool = true
@export var SPEED = 100.0
@export var ACCELERATION = 300.0
@export var FRICTION = 300.0
#@onready var Sprite = $AnimatedSprite2D
@onready var world = get_node('/root/World')
@onready var cooldown_timer = $Shoot_Timer
@onready var Sprite = $AnimationTree.get("parameters/playback")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var GunShot = $GunShot
@onready var hehe = $"../Main Room/hehe"
@onready var hehe2 = $"../Other_Room/hehe2"
@onready var hehe3 = $"../Other_Room2/hehe3"
@onready var hehe4 = $"../hallway/hehe4"
@onready var hehe5 = $"../hallway_2/hehe5"
@onready var hehe6 =$"../Area2D/hehe6"
@onready var crosshair = $"../Crosshair"
var direction = Vector2.ZERO
@onready var CameraShake = $CameraShake
var reload = 4
@onready var ray_cast_2d = $RayCast2D
func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
		var mouse_pos = get_global_mouse_position()
		var shoot = Input.is_action_pressed("shoot") 
		var run = Input.is_action_pressed("run")
		#Movement
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		if direction and run:
			velocity = velocity.move_toward(direction * SPEED * 2, ACCELERATION)
			Sprite.travel("Running") 
		elif direction:
			velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
			Sprite.travel("Walking")
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			Sprite.travel("Idle")
		
		if velocity.x > 0:
			animated_sprite_2d.flip_h = true
		elif velocity.x < 0:
			animated_sprite_2d.flip_h = false
	
	#Shoot Mechanics
		
		if Input.is_action_just_pressed("shoot") and is_ready:
			CameraShake.play("Cam_Shake")
			$Shoot_Timer.start()
			is_ready = false
			Sprite.travel("Shoot")
			$GunShot.play()
		
			var collider = ray_cast_2d.get_collider()
			if collider:
				print(collider.name)
				if collider.is_in_group("Enemy"):
					print("Hit the bastard") 
					if not collider.owner.dead:
						collider.owner.hit()
		else:
			pass
		
		
		if reload == 0:
			print()
			
		else:
			pass
			
		crosshair.position = mouse_pos

func _on_shoot_timer_timeout():
	is_ready = true



func _process(delta):
	look_at(get_global_mouse_position())

	rotation_degrees += 90
	
	
	
	move_and_slide()
	













func _on_main_room_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.hide()
	hehe2.show()
	hehe3.show()
	hehe4.show()
	hehe5.show()
	hehe6.show()

func _on_other_room_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.show()
	hehe2.hide()
	hehe3.show()
	hehe4.show()
	hehe5.show()
	hehe6.show()

func _on_hallway_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.show()
	hehe2.show()
	hehe3.show()
	hehe4.hide()
	hehe5.show()
	hehe6.show()



func _on_hallway_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.show()
	hehe2.show()
	hehe3.show()
	hehe4.show()
	hehe5.hide()
	hehe6.show()



func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.show()
	hehe2.show()
	hehe3.show()
	hehe4.show()
	hehe5.show()
	hehe6.hide()


func _on_other_room_2_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hehe.show()
	hehe2.show()
	hehe3.hide()
	hehe4.show()
	hehe5.show()
	hehe6.show()
